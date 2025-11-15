extends Camera3D

@export var camera : int = 1
@onready var CameraPivot : Node3D = %CameraPivot
@onready var Player : CharacterBody3D = get_parent().get_parent()
const MOUSE_SENSIBILITY : float = 0.5
const CAMERA_POSITIONS : Array = [Vector3(0, 0, 0), Vector3(0, 0, 3)]
var max_camera_y : Array = [deg_to_rad(-80), deg_to_rad(80)]

func _physics_process(_delta: float) -> void:	
	if Input.is_action_just_pressed("ui_camera"):
		camera *= -1
		if camera == 1:
			position = CAMERA_POSITIONS[0]
			max_camera_y[1] = deg_to_rad(80)
		else:
			position = CAMERA_POSITIONS[1]
			max_camera_y[1] = deg_to_rad(10)
	
		CameraPivot.rotation.x = clamp(CameraPivot.rotation.x, max_camera_y[0], max_camera_y[1])


func _input(event: InputEvent) -> void:
	if event is InputEventMouseButton:
		Input.mouse_mode = Input.MOUSE_MODE_CAPTURED
	elif event.is_action_pressed("ui_cancel"):
		Input.mouse_mode = Input.MOUSE_MODE_VISIBLE
	elif event is InputEventMouseMotion and Input.mouse_mode == Input.MOUSE_MODE_CAPTURED:
		Player.rotate_y(event.relative.x * MOUSE_SENSIBILITY * get_process_delta_time() * -1)
		
		CameraPivot.rotate_x(event.relative.y * MOUSE_SENSIBILITY * get_process_delta_time() * -1)
		CameraPivot.rotation.x = clamp(CameraPivot.rotation.x, max_camera_y[0], max_camera_y[1])
