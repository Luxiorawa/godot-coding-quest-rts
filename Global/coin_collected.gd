class_name CoinCollected
extends Label

const travel := Vector2(0, -30)
const duration := 1
const spread := PI/2

func show_label(value: int) -> void:
	var tween := create_tween()
	text = "+ " + str(value) + "g"
	pivot_offset = size / 4
	var movement := travel.rotated(randi_range(-spread / 2, spread / 2))
	tween.tween_property(self, "position", position + movement, duration)
	tween.tween_property(self, "modulate:a", 0.0, duration)
	tween.play()
	tween.tween_callback(queue_free)