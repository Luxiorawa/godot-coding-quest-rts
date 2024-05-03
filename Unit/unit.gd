extends CharacterBody2D

@export var selected := false
@onready var box: Panel = $Box

func _ready() -> void:
	set_selected(selected)
	
func set_selected(value: bool) -> void:
	box.visible = value

func _on_input_event(viewport, event, shape_idx) -> void:
	pass
