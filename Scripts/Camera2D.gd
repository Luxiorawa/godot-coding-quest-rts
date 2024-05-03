extends Camera2D

var mousePos := Vector2()
var mousePosGlobal := Vector2()
var start := Vector2()
var startV := Vector2()
var end := Vector2()
var endV := Vector2()
var isDragging := false
@onready var panel: Panel = $"../UI/Panel"

signal area_selected(object: Node2D)
signal start_move_selection

func _ready() -> void:
	area_selected.connect(get_parent()._on_area_selected)
	
func _process(_delta: float) -> void:
	if Input.is_action_just_pressed("LeftClick"):
		start = mousePosGlobal
		startV = mousePos
		isDragging = true
		print("Click pressed at", start)
	
	if isDragging:
		end = mousePosGlobal
		endV = mousePos
		draw_area()
	
	if Input.is_action_just_released("LeftClick"):
		end = mousePosGlobal
		endV = mousePos
		isDragging = false
		area_selected.emit(self)
		reset_area()
		print("Click released at", end)
		
func _input(event) -> void:
	if event is InputEventMouse:
		mousePos = event.position
		mousePosGlobal = get_global_mouse_position()

func draw_area() -> void:
	panel.visible = true
	panel.size = Vector2(abs(startV.x - endV.x), abs(startV.y - endV.y))
	var pos := Vector2()
	pos.x = min(startV.x, endV.x)
	pos.y = min(startV.y, endV.y)
	panel.position = pos
	
func reset_area() -> void:
	panel.size = Vector2(0, 0)
	panel.visible = false
