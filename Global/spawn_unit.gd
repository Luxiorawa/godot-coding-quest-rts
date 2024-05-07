class_name SpawnUnit
extends Node2D

@onready var unit := preload("res://unit/unit.tscn")
var housePosition := Vector2(300, 300)

func _on_yes_pressed() -> void:
	var unitPath: Node2D = get_tree().get_root().get_node("World/Units")
	var newUnit: Unit = unit.instantiate()

	var rng := RandomNumberGenerator.new()
	rng.randomize()
	var randomPosX := rng.randi_range(-50, 50)
	var randomPosY := rng.randi_range(-50, 50)
	newUnit.position = housePosition + Vector2(randomPosX, randomPosY)
	unitPath.add_child(newUnit)

	# Va aller mettre à jour le tableau d'unités, afin de permettre la sélection et autre process lié aux unités dans world.gd
	var worldPath: World = get_tree().get_root().get_node("World")
	worldPath.load_units()
	 

func _on_no_pressed() -> void:
	var housePath := get_tree().get_root().get_node("World/Houses")
	for i in housePath.get_child_count():
		var currentHouse: BarbHouse = housePath.get_child(i)
		if currentHouse.isSelected == true:
			currentHouse.isSelected = false
	queue_free()
