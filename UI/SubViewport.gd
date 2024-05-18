class_name Minimap
extends SubViewport

@onready var minimapCamera: Camera2D = get_node("Camera2D")
var barrack := preload("res://UI/Minimap-sprites/barrack-sprite.tscn")
var coinHouse := preload("res://UI/Minimap-sprites/coin-house-sprite.tscn")
var tree := preload("res://UI/Minimap-sprites/tree-sprite.tscn")
var arthax := preload("res://UI/Minimap-sprites/arthax-sprite.tscn")

func _ready() -> void:
	updateMap()

func updateMap() -> void:
	var housesNode: Node2D = get_node("Houses")
	var ressourcesNode: Node2D = get_node("Ressources")
	var objectsNode: Node2D = get_node("Objects")

	resetMap(housesNode, ressourcesNode, objectsNode)

	var root := get_tree().get_root()
	var barracksPath := root.get_node("World/Houses")
	var ressources := root.get_node("World/Ressources")
	var worldObjects := root.get_node("World/Objects")
	var unitsPath := root.get_node("World/Units")
	
	for i in barracksPath.get_child_count():
		var originalBarrack: BarbHouse = barracksPath.get_child(i)
		var newBarrack: Sprite2D = barrack.instantiate()
		newBarrack.name = "Barrack" + str(i)
		newBarrack.position = originalBarrack.position / 2
		housesNode.add_child(newBarrack)

	for i in ressources.get_child_count():
		var originalRessource: CoinHouse = ressources.get_child(i)
		var newCoinHouse: Sprite2D = coinHouse.instantiate()
		newCoinHouse.name = "CoinHouse" + str(i)
		newCoinHouse.position = originalRessource.position / 2
		ressourcesNode.add_child(newCoinHouse)

	for i in worldObjects.get_child_count():
		var originalTree: TreeWorldObject = worldObjects.get_child(i)
		var newTree: Sprite2D = tree.instantiate()
		newTree.name = "Tree" + str(i)
		newTree.position = originalTree.position / 2
		objectsNode.add_child(newTree)

	for i in unitsPath.get_child_count():
		var newUnit: Sprite2D = arthax.instantiate()
		newUnit.name = "Unit" + str(i)
		get_node("Units").add_child(newUnit)

func resetMap(housesNode: Node2D, ressourcesNode: Node2D, objectsNode: Node2D) -> void:
	for i in housesNode.get_child_count():
		housesNode.get_child(i).queue_free()

	for i in ressourcesNode.get_child_count():
		ressourcesNode.get_child(i).queue_free()

	for i in objectsNode.get_child_count():
		objectsNode.get_child(i).queue_free()

func _process(_delta: float) -> void:
	var root := get_tree().get_root()
	var playerCamera: Camera2D = root.get_node("World/Camera2D")
	minimapCamera.position = playerCamera.position / 2
	minimapCamera.zoom = playerCamera.zoom / 2

	# On va aller récupérer les unités à chaque frame, afin de gérer le déplacements de celles-ci. Dans l'idée, tout ce qui se déplace, qui peut être détruit..etc
	# devra je suppose être traité ici ? (Ressources vide, batiment détruit ou autre)

	var unitsPath: Node2D = root.get_node("World/Units")
	var totalUnits: Node2D = get_node("Units")
	for i in unitsPath.get_child_count():
		var originalUnit: Unit = unitsPath.get_child(i)
		var currentUnit: Sprite2D = totalUnits.get_child(i)
		currentUnit.position = originalUnit.position / 2