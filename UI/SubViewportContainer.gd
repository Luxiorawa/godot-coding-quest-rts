extends SubViewportContainer

@onready var camera: Camera2D = $Camera
var barrack := preload("res://UI/Minimap-sprites/barrack-sprite.tscn")
var coinHouse := preload("res://UI/Minimap-sprites/coin-house-sprite.tscn")
var tree := preload("res://UI/Minimap-sprites/tree-sprite.tscn")
var arthax := preload("res://UI/Minimap-sprites/arthax-sprite.tscn")

func _ready() -> void:
	updateMap()

func updateMap() -> void:
	pass

func _process(_delta: float) -> void:
	
	pass