extends CharacterBody3D

@onready var CameraPivot : Node3D = %CameraPivot
@onready var Camera : Camera3D = %Camera
@onready var TimerDash : Timer = %TimerDash
const MOUSE_SENSIBILITY : float = 0.5
const ACELERATION : float = 50.0
const FRICTION : float = 0.1
const GRAVITY : float = 60.0
const JUMP_FORCE : float = 15.0
const DASH_FORCE : float = 20.0
const DASH_COWDOWN : float = 0.5
const MAX_VELOCITY : float = 25.0
const max_camera_y : Array = [deg_to_rad(-80), deg_to_rad(80)]
var double_jump : bool = true

func  _ready() -> void:
	TimerDash.one_shot = true
	TimerDash.wait_time = DASH_COWDOWN

func _physics_process(_delta: float) -> void:
	var direction = Input.get_vector("ui_left", "ui_right", "ui_up", "ui_down")
	var move_direction = Vector3(direction.x, 0, direction.y)
	velocity += transform.basis * move_direction * ACELERATION * _delta
	
	velocity.x *= 1 - FRICTION
	velocity.z *= 1 - FRICTION
	
	if velocity.x > MAX_VELOCITY:
		velocity.x = MAX_VELOCITY
	elif velocity.x < -MAX_VELOCITY:
		velocity.x = -MAX_VELOCITY

	if velocity.z > MAX_VELOCITY:
		velocity.z = MAX_VELOCITY
	elif velocity.z < -MAX_VELOCITY:
		velocity.z = -MAX_VELOCITY
	
	if not is_on_floor():
		velocity.y -= GRAVITY * _delta
		
		if double_jump and Input.is_action_just_pressed("ui_jump"):
				velocity.y = JUMP_FORCE
				double_jump = false
	else:
		double_jump = true
		
		if Input.is_action_just_pressed("ui_jump"):
			velocity.y = JUMP_FORCE
	
	if Input.is_action_just_pressed("ui_dash") and TimerDash.is_stopped():
		var dash_direction = -transform.basis.z
		velocity.x += dash_direction.x * DASH_FORCE
		velocity.z += dash_direction.z * DASH_FORCE
		
		TimerDash.start()
	
	move_and_slide()

func _input(event: InputEvent) -> void:
	if event is InputEventMouseButton:
		Input.mouse_mode = Input.MOUSE_MODE_CAPTURED
	elif event.is_action_pressed("ui_cancel"):
		Input.mouse_mode = Input.MOUSE_MODE_VISIBLE
	elif event is InputEventMouseMotion and Input.mouse_mode == Input.MOUSE_MODE_CAPTURED:
		rotate_y(event.relative.x * MOUSE_SENSIBILITY * get_process_delta_time() * -1)
		
		CameraPivot.rotate_x(event.relative.y * MOUSE_SENSIBILITY * get_process_delta_time() * -1)
		CameraPivot.rotation.x = clamp(CameraPivot.rotation.x, max_camera_y[0], max_camera_y[1])
