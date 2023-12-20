extends CharacterBody2D

#player movement variables
@export var speed = 100
@export var gravity = 200

var double_jump = true


#movement and physics
func _physics_process(delta):
	#reset double
	if is_on_floor():
		double_jump = true
	
	#handle flip
	if Input.is_action_pressed("ui_right"):
		$AnimatedSprite2D.flip_h = false
	if Input.is_action_pressed("ui_left"):
		$AnimatedSprite2D.flip_h = true
	# vertical movement velocity (down)
	velocity.y += gravity * delta
	# horizontal movement processing (left, right)
	horizontal_mvt()
	#applies movement
	move_and_slide() 
	
	if (not Global.is_attacking) && (not Global.is_jumping) && not Input.is_action_pressed("ui_up"):
		player_animations()

func horizontal_mvt() :
	var direction = Input.get_action_strength("ui_right") - Input.get_action_strength("ui_left")
	velocity.x = direction * speed 
	
#animations
func player_animations():
	#on left (add is_action_just_released so you continue running after jumping)
	if Input.is_action_pressed("ui_left"):
		$AnimatedSprite2D.play("run")

	#on right (add is_action_just_released so you continue running after jumping)
	if Input.is_action_pressed("ui_right"):
		$AnimatedSprite2D.play("run")
	
	#on idle
	if !Input.is_anything_pressed():
		$AnimatedSprite2D.play("idle")
	
	 #singular input captures
func _input(event):
	
	#on attack
	if event.is_action_pressed("ui_attack"):
		Global.is_attacking = true
		$AnimatedSprite2D.play("attack")
		
	#on jump
	if event.is_action_pressed("ui_jump") and is_on_floor() and not Global.is_climbing:
		Global.is_jumping = true
		velocity.y = Global.jump_height
		$AnimatedSprite2D.play("jump")
	
	if event.is_action_pressed("ui_jump") and not is_on_floor() and double_jump:
		Global.is_jumping = true
		double_jump = false
		velocity.y = Global.jump_height
		$AnimatedSprite2D.play("jump")
		
	#on climb
	if Global.is_climbing == true:
		if !Input.is_anything_pressed():    
			$AnimatedSprite2D.play("idle")
		if Input.is_action_pressed("ui_up"):
			$AnimatedSprite2D.play("climb") 
			gravity = 100
			velocity.y = -100
	#reset gravity
	else:
		gravity = 200


func _on_animated_sprite_2d_animation_finished():
	Global.is_attacking = false
	Global.is_climbing = false
	Global.is_jumping = false
