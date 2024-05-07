extends CanvasLayer

@onready var label: Label = $Label

func _process(_delta: float) -> void:
	label.text = "Wood: " + str(Game.Wood)