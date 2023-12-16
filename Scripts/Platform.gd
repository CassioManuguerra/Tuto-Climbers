extends Area2D

enum State {WAIT_AT_BOTTOM, MOVING_UP, WAIT_AT_TOP, MOVING_DOWN}

@onready var timer = $Timer
var current_state = State.WAIT_AT_BOTTOM
var initial_position
var progress = 0.0

#platforms movement speed and range
@export var movement_speed = 50.0
@export var movement_range = 50

#wait times
@export  var wait_time_at_top = 3.0 # Time in seconds to wait at top
@export var wait_time_at_bottom = 3.0 # Time in seconds to wait at to

func _on_timer_timeout():
	#handle timer
	if current_state == State.WAIT_AT_BOTTOM:
		switch_state(State.MOVING_UP)
	if current_state == State.WAIT_AT_TOP:
		switch_state(State.MOVING_DOWN)

func _ready():
	initial_position = position.y
	switch_state(State.MOVING_UP)

func _physics_process(delta):
	match current_state:
		State.MOVING_UP:
			progress += delta
			position.y = lerp(initial_position, initial_position - movement_range, progress / (movement_range / movement_speed))
			if progress >= movement_range / movement_speed:
				switch_state(State.WAIT_AT_TOP)
		State.MOVING_DOWN:
			progress -= delta
			position.y = lerp(initial_position, initial_position - movement_range, progress / (movement_range / movement_speed))
			if progress <= 0:
				switch_state(State.WAIT_AT_BOTTOM)
#changes the platforms movement states
func switch_state(new_state):
	current_state = new_state
	match new_state:
		#if state is moving up, reset progress
		State.MOVING_UP:
			progress = 0.0

		#if state is waiting at top, start the timer to change the state
		State.WAIT_AT_TOP:
			timer.wait_time = wait_time_at_top #will wait x seconds before moving
			timer.start()

		#if state is waiting at bottom, start the timer to change the state
		State.WAIT_AT_BOTTOM:
			timer.wait_time = wait_time_at_bottom #will wait x seconds before moving
			timer.start()

		#if state is moving down, move the platform via the speed and range defined
		State.MOVING_DOWN:
			progress = movement_range / movement_speed
