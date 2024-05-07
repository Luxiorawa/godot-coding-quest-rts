class_name CoinHouse
extends StaticBody2D

var coinCollected := preload("res://Global/coin_collected.tscn")

var totalTime := 50
var currentTime: int

@onready var progressBar: ProgressBar = $ProgressBar
@onready var timer: Timer = $Timer

func _ready() -> void:
	currentTime = totalTime
	progressBar.max_value = totalTime
	timer.start()

func _process(_delta: float) -> void:
	if currentTime <= 0:
		collectCoin()


func _on_timer_timeout() -> void:
	currentTime -= 1
	var tween := get_tree().create_tween()
	tween.tween_property(progressBar, "value", currentTime, timer.wait_time).set_trans(Tween.TRANS_LINEAR)

func collectCoin() -> void:
	Game.Coin += 10
	_ready()
	var coinCollectedInstantiated: CoinCollected = coinCollected.instantiate()
	add_child(coinCollectedInstantiated)
	coinCollectedInstantiated.show_label(10)
