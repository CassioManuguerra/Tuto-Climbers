extends Area2D

enum State {WAIT_AT_RIGHT, MOVING_LEFT, WAIT_AT_LEFT, MOVING_RIGHT}

@onready var timer = $Timer
var current_state = State.WAIT_AT_RIGHT
var initial_position
var progress = 0.0

#platforms movement speed and range
@export var movement_speed = 50.0
@export var movement_range = 50

#wait times
@export  var wait_time_at_left = 3.0 # Time in seconds to wait at top
@export var wait_time_at_right = 3.0 # Time in seconds to wait at to

func _on_timer_timeout():
	#handle timer
	if current_state == State.WAIT_AT_RIGHT:
		switch_state(State.MOVING_LEFT)
	if current_state == State.WAIT_AT_LEFT:
		switch_state(State.MOVING_RIGHT)

func _ready():
	initial_position = position.x
	switch_state(State.MOVING_LEFT)

func _physics_process(delta):
	match current_state:
		State.MOVING_LEFT:
			progress += delta
			position.x = lerp(initial_position, initial_position - movement_range, progress / (movement_range / movement_speed))
			if progress >= movement_range / movement_speed:
				switch_state(State.WAIT_AT_LEFT)
		State.MOVING_RIGHT:
			progress -= delta
			position.x = lerp(initial_position, initial_position - movement_range, progress / (movement_range / movement_speed))
			if progress <= 0:
				switch_state(State.WAIT_AT_RIGHT)
#changes the platforms movement states
func switch_state(new_state):
	current_state = new_state
	match new_state:
		#if state is moving up, reset progress
		State.MOVING_LEFT:
			progress = 0.0

		#if state is waiting at top, start the timer to change the state
		State.WAIT_AT_LEFT:
			timer.wait_time = wait_time_at_left #will wait x seconds before moving
			timer.start()

		#if state is waiting at bottom, start the timer to change the state
		State.WAIT_AT_RIGHT:
			timer.wait_time = wait_time_at_right #will wait x seconds before moving
			timer.start()

		#if state is moving down, move the platform via the speed and range defined
		State.MOVING_RIGHT:
			progress = movement_range / movement_speed
