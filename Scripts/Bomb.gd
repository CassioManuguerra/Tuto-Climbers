extends Area2D
@onready var bomb = $AnimatedSprite2D
@onready var timer = $Timer

func _ready():
	bomb.play("moving")
	

func _on_body_entered(body):
	if body.name == "Player":
		bomb.play("explode")
		timer.start()
	if body.name == "Wall":
		bomb.play("explode")
		timer.start()


func _on_timer_timeout():
	if is_instance_valid(self):
		self.queue_free()
