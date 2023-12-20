extends Area2D
@onready var bomb = $AnimatedSprite2D
@onready var timer = $Timer

var rotation_speed = 10

func _ready():
	bomb.play("moving")
	

func _on_body_entered(body):
	if body.name == "Player":
		Global.bomb_finished_exploding = false
		Global.freezeBomb = true
		bomb.play("explode")
		timer.start()
		Global.is_bomb_moving = false
	if body.name == "Wall":
		Global.bomb_finished_exploding = false
		Global.freezeBomb = true
		bomb.play("explode")
		timer.start()
		Global.is_bomb_moving = false


func _on_timer_timeout():
	Global.bomb_finished_exploding = true

func _physics_process(delta):
	if Global.is_bomb_moving == true:
		$AnimatedSprite2D.rotation += rotation_speed * delta
	
