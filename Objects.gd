extends Node2D

@onready var tree := preload("res://World Objects/tree.tscn")
@onready var house := preload("res://Houses/coin_house.tscn")

const tileSize := 16
const gridSize := Vector2(2500, 1000)
const numberOfTree := 100

var grid: Array[Array] = []

func _ready() -> void:
	fillArray()

	var positions := []
	var treePlaced := 0
	while treePlaced < numberOfTree:
		var xCoords := randi() % int(gridSize.x)
		var yCoords := randi() % int(gridSize.y)
		var gridPosition := Vector2(xCoords, yCoords)
		if not gridPosition in positions:
			var newTree: TreeWorldObject = tree.instantiate()
			newTree.position = gridPosition
			newTree.name = "Tree" + str(treePlaced)
			add_child(newTree)
			positions.append(gridPosition)
			grid[xCoords][yCoords] = newTree.name
			treePlaced += 1

func fillArray() -> void:
	# On va remplir un tableau à 2 dimensions, qui fera office de Tilemap custom.
	# La première boucle créer 160x un tableau vide (qui feront office de "ligne")
	# Et la deuxième boucle créera 160x celulle "null" (qui feront office de "colonne", et qui créeront donc des cellules)
	for x in range(gridSize.x):
		grid.append([])
		for y in range(gridSize.y):
			grid[x].append(null)