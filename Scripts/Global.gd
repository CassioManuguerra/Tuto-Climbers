extends Node

#actions booleans
var is_climbing = false
var is_attacking = false
var is_jumping = false

var is_bomb_moving = false
var bomb_finished_exploding = true
var freezeBomb = false

#cannonhandler
var set_match = false

#height
var jump_height = -80

var current_scene_name

func _ready():
		# Sets the current scene's name
		current_scene_name = get_tree().get_current_scene().name
