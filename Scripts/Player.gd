extends CharacterBody2D

#player movement variables
@export var speed = 100
@export var gravity = 200


#movement and physics
func _physics_process(delta):
	# vertical movement velocity (down)
	velocity.y += gravity * delta
	# horizontal movement processing (left, right)
	horizontal_mvt()
	#applies movementt
	move_and_slide() 

func horizontal_mvt() :
	var direction = Input.get_action_strength("ui_right") - Input.get_action_strength("ui_left")
	velocity.x = direction * speed 
