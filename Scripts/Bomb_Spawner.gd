extends Node2D
	
var bomb = preload("res://Scenes/Bomb.tscn")
var current_scene_path
var bomb_animation
var bomb_path
@onready var timer = $Timer

func _ready():
	#default animation on load
	$AnimatedSprite2D.play("cannon_idle")   
	#initiates paths
	current_scene_path = "/root/" + Global.current_scene_name + "/" #current scene
	bomb_path = get_node(current_scene_path + "/Bomb_Path/Path2D/PathFollow2D") #PathFollow2D
	bomb_animation = get_node(current_scene_path + "/Bomb_Path/Path2D/AnimationPlayer") #AnimationPlayer
	Global.is_bomb_moving = true
	timer.start()

	
func shoot():
	#play cannon shoot animation each time the function is fired off
	$AnimatedSprite2D.play("cannon_fired")
	#sets the bomb to moving and plays bomb animation
	Global.is_bomb_moving = true
	bomb_animation.play("bomb_movement")
	#returns spawned bomb
	var spawned_bomb = bomb.instantiate()
	return spawned_bomb


func _on_timer_timeout():
	#reset animation before shooting    
	$AnimatedSprite2D.play("cannon_idle")
	#spawns a bomb onto our path if there are no bombs available
	if bomb_path.get_child_count() <= 0:
		bomb_path.add_child(shoot())
		Global.set_match = true
	timer.start()
	
	
func _process(delta):
	#freeze bomb
	if Global.freezeBomb :
		bomb_animation.pause()
	# Clear all existing bombs 
	if Global.is_bomb_moving == false and Global.bomb_finished_exploding:
		for bombs in bomb_path.get_children():
			bomb_path.remove_child(bombs)
			bombs.queue_free()
			bomb_animation.stop()
			

