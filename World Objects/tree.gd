class_name TreeWorldObject
extends StaticBody2D

var totalTime := 5
var currentTime: int
var units := 0
@onready var progressBar: ProgressBar = $ProgressBar
@onready var timer: Timer = $Timer

func _ready() -> void:
	currentTime = totalTime
	progressBar.max_value = totalTime

func _process(_delta: float) -> void:
	if currentTime <= 0:
		treeChopped()

func _on_timer_timeout() -> void:
	currentTime -= 1 * units
	var tween := get_tree().create_tween()
	tween.tween_property(progressBar, "value", currentTime, 0.2).set_trans(Tween.TRANS_LINEAR)
	
func _on_chop_area_body_entered(body:Node2D) -> void:
	if "Unit" in body.name:
		units += 1
		startChopping()

func _on_chop_area_body_exited(body:Node2D) -> void:
	if "Unit" in body.name:
		units -= 1
		if(units <= 0):
			timer.stop()

func startChopping() -> void:
	timer.start()

func treeChopped() -> void:
	Game.Wood += 10
	queue_free()
