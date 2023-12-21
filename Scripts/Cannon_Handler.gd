extends Node2D
@onready var anim = $anim
var one_time = false
var current_speech
var random_speech
func _ready():
	
	$Body.play("idle")
func _process(delta):
	$Timer.wait_time = randi_range(10, 15)
	#idle animation
	if Global.is_bomb_moving == true and Global.set_match == false:
		$Body.play("idle")  
		#show speech bubble
		$SpeechBubble.visible = true
		one_time = false
	if Global.is_bomb_moving == false and one_time == false:
		$Body.play("matching")
		#hide speech bubble
		$SpeechBubble.visible = false
		one_time = true
		anim.start()
func _on_timer_timeout():
	#randomizes speech
	while current_speech == random_speech :
		random_speech = randi() % 3 #will return 0, 1, or 2
	match random_speech:
		0:
			$SpeechBubble.play("gronaz")
			current_speech = 0
		1:
			$SpeechBubble.play("tupu")
			current_speech = 1
		2:
			$SpeechBubble.play("monmeda")
			current_speech = 2


func _on_anim_timeout():
	Global.set_match = false
