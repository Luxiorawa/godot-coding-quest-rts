extends Node

@onready var spawnUI := preload("res://Global/spawn_unit.tscn")

var Wood := 0

func spawnUnitUI(unitPosition: Vector2) -> void:
	var path := get_tree().get_root().get_node("World/UI")

	if path.get_node_or_null("SpawnUnit"):
		return

	var unitSpawnUI: SpawnUnit = spawnUI.instantiate()
	unitSpawnUI.housePosition = unitPosition 
	path.add_child(unitSpawnUI)
