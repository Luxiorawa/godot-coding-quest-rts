class_name CoinCollected
extends Label

var travel := Vector2(0, -30)
var duration := 1
var spread := PI/2

func show_label(value: int) -> void:
	var tween := create_tween()
	text = "+ " + str(value) + "g"
	pivot_offset = size / 4
	# Je comprends rien à comment ça marche, ni même pourquoi en appliquant une ROTATION cela déplace le label vers le haut ??
	var movement := travel.rotated(randi_range(-spread/2, spread/2))
	print(position, movement)
	tween.tween_property(self, "position", position + movement, duration)
	tween.tween_property(self, "modulate:a", 0.0, duration)
	tween.play()
	tween.tween_callback(queue_free)