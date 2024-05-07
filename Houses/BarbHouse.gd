class_name BarbHouse
extends StaticBody2D

var isSelected := false
@onready var selected: Panel = $Selected

var mouseEntered := false

func _process(_delta: float) -> void:
	selected.visible = isSelected

func _input(event: InputEvent) -> void:
	if event.is_action_pressed("LeftClick") and mouseEntered == true:
		isSelected = !isSelected
		if isSelected == true:
			Game.spawnUnitUI(self.position)

func _on_mouse_entered() -> void:
	mouseEntered = true

func _on_mouse_exited() -> void:
	mouseEntered = false
