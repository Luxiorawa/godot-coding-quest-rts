class_name Camera
extends Camera2D

# Camera Control
@export var speed := 20.0
@export var zoom_speed := 50.0
@export var zoom_margin := 0.1
@export var zoom_min := 0.5
@export var zoom_max := 3.0
var zoomFactor := 1.0
var zoomPos := Vector2()
var zooming := false

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
	var parent := get_parent() as World
	area_selected.connect(parent._on_area_selected)
	
func _process(delta: float) -> void:
	# La soustraction de right / left et de down / up permet d'avoir une seule valeur gérant le cas où les deux touches sont appuyés en même temps
	var inputX := int(Input.is_action_pressed("Right")) - int(Input.is_action_pressed("Left"))
	var inputY := int(Input.is_action_pressed("Down")) - int(Input.is_action_pressed("Up"))

	position.x = lerpf(position.x, position.x + inputX * speed * zoom.x, speed * delta)
	position.y = lerpf(position.y, position.y + inputY * speed * zoom.y, speed * delta)

	zoom.x = clamp(lerp(zoom.x, zoom.x * zoomFactor, zoom_speed * delta), zoom_min, zoom_max)
	zoom.y = clamp(lerp(zoom.y, zoom.y * zoomFactor, zoom_speed * delta), zoom_min, zoom_max)

	if not zooming:
		zoomFactor = 1.0

	if Input.is_action_just_pressed("LeftClick"):
		start = mousePosGlobal
		startV = mousePos
		isDragging = true
	
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
		
func _input(event: InputEvent) -> void:
	if abs(zoomPos.x - get_global_mouse_position().x) > zoom_margin:
		zoomFactor = 1.0

	if abs(zoomPos.y - get_global_mouse_position().y) > zoom_margin:
		zoomFactor = 1.0

	if event is InputEventMouse:
		var mouse_event := event as InputEventMouse
		mousePos = mouse_event.position
		mousePosGlobal = get_global_mouse_position()

	if event is InputEventMouseButton:
		if event.is_pressed():
			zooming = true
			if event.is_action("WheelDown"):
				zoomFactor -= 0.01 * zoom_speed
				zoomPos = get_global_mouse_position()
			if event.is_action("WheelUp"):
				zoomFactor += 0.01 * zoom_speed
				zoomPos = get_global_mouse_position()
		else:
			zooming = false

func draw_area() -> void:
	panel.visible = true
	panel.size = Vector2(abs(startV.x - endV.x) as float, abs(startV.y - endV.y) as float)
	var pos := Vector2()
	pos.x = min(startV.x, endV.x)
	pos.y = min(startV.y, endV.y)
	panel.position = pos
	
func reset_area() -> void:
	panel.size = Vector2(0, 0)
	panel.visible = false
