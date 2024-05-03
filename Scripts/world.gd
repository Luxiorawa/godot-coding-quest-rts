extends Node2D

var units: Array = []

func _ready() -> void:
	units = get_tree().get_nodes_in_group("units")

func _on_area_selected(object: Node2D) -> void:
	var start = object.start
	var end = object.end
	# [0] = Vecteur associé au moment du clic
	# [1] = Vecteur associé au release du clic
	var area: Array[Vector2] = [
		Vector2(min(start.x, end.x), min(start.y, end.y)), 
		Vector2(max(start.x, end.x), max(start.y, end.y))
	]

	var units_selected = get_units_in_area(area)
	for unit in units:
		# Avant de sélectionner les unités, on va toutes les déselectionner au préalable
		unit.set_selected(false)
		
	for unit in units_selected:
		unit.set_selected(!unit.selected)

	print("Selected ", units_selected.size(), " unit", "s" if units_selected.size() > 1 else "")

func get_units_in_area(area: Array[Vector2]) -> Array:
	var units_selected = []
	for unit in units:
		if unit.position.x >= area[0].x and unit.position.x <= area[1].x and unit.position.y >= area[0].y and unit.position.y <= area[1].y:
			"""
				On va aller checker si la position sur l'axe X de l'unité est comprise entre la position X 
				du clic et la position X du release et on va faire de même pour la position sur l'axe Y 
			"""
			units_selected.append(unit)
	return units_selected
