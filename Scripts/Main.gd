extends Node2D

@onready var player = $Player
@onready var timer = $easterrrr/Timer
@onready var easterrrr = $easterrrr/easterrrr

var r = false
var h = false
var e = false
var y = false

func _process(delta):
	
	if player.position.x >= 500 && player.position.y >= 100:
		if Input.is_action_pressed("ui_r"):
			r = true
		else:
			if Input.is_action_pressed("ui_h") and r:
				h = true
			else:
				if Input.is_action_pressed("ui_e") and r and h:
					e = true
				else:
					if Input.is_action_pressed("ui_y") and r and h and e:
						easterrrr.play("trigger")
						easterrrr.visible = true
						timer.start()
					else:
						if Input.is_anything_pressed():
							r = false 
							h = false 
							e = false 
							y = false 


func _on_timer_timeout():
	easterrrr.visible = false
	easterrrr.stop()
