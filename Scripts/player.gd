extends CharacterBody3D

@onready var TimerDash : Timer = %TimerDash
const ACELERATION : float = 50.0
const FRICTION : float = 0.1
const GRAVITY : float = 60.0
const JUMP_FORCE : float = 15.0
const DASH_FORCE : float = 20.0
const DASH_COWDOWN : float = 0.5
const MAX_VELOCITY_X_Z : float = 25.0
const MAX_VELOCITY_Y : float = 30.0
const LENTIDAO_NADANDO : float = 0.3
const GRAVITY_NADANDO : float = 20.0
const JUMP_FORCE_NADANDO : float = 25.0
var double_jump : bool = true
var nadando : bool = false

func  _ready() -> void:
	TimerDash.one_shot = true
	TimerDash.wait_time = DASH_COWDOWN

func _physics_process(delta: float) -> void:
	move_and_jump(delta)
	print(nadando)

	move_and_slide()

func move_and_jump(delta):
	var direction = Input.get_vector("ui_left", "ui_right", "ui_up", "ui_down")
	var move_direction = Vector3(direction.x, 0, direction.y)	
	velocity += transform.basis * move_direction * ACELERATION * delta
	
	velocity.x *= 1 - FRICTION
	velocity.z *= 1 - FRICTION
	
	if velocity.x > MAX_VELOCITY_X_Z:
		velocity.x = MAX_VELOCITY_X_Z
	elif velocity.x < -MAX_VELOCITY_X_Z:
		velocity.x = -MAX_VELOCITY_X_Z

	if velocity.z > MAX_VELOCITY_X_Z:
		velocity.z = MAX_VELOCITY_X_Z
	elif velocity.z < -MAX_VELOCITY_X_Z:
		velocity.z = -MAX_VELOCITY_X_Z
	
	if velocity.y > MAX_VELOCITY_Y:
		velocity.y = MAX_VELOCITY_Y
	elif velocity.y < -MAX_VELOCITY_Y:
		velocity.y = -MAX_VELOCITY_Y
	
	var gravidade_atual : float
	var jump_force_atual : float
	
	if nadando:
		gravidade_atual = GRAVITY_NADANDO
		jump_force_atual = JUMP_FORCE_NADANDO
		velocity *= LENTIDAO_NADANDO
	else:
		gravidade_atual = GRAVITY
		jump_force_atual = JUMP_FORCE
	
	if not is_on_floor():
		velocity.y -= gravidade_atual * delta
		
		if double_jump and Input.is_action_just_pressed("ui_jump"):
				velocity.y += jump_force_atual
				double_jump = false
	else:
		double_jump = true
		
		if Input.is_action_just_pressed("ui_jump"):
			velocity.y += jump_force_atual
	
	if Input.is_action_just_pressed("ui_dash") and TimerDash.is_stopped():
		var dash_direction = -transform.basis.z
		velocity.x += dash_direction.x * DASH_FORCE
		velocity.z += dash_direction.z * DASH_FORCE
		
		TimerDash.start()
