extends DirectionalLight3D

@export var DURATION_SUN : float = 100
@export var DURATION_SKY_COLOR : float = 150
@onready var WorldSky : ProceduralSkyMaterial = %WorldEnvironment.environment.sky.sky_material

func _ready() -> void:	
	var tween := get_tree().create_tween()
	tween.parallel().tween_property(self, "rotation_degrees", Vector3(-270, 0, 0), DURATION_SUN)
	tween.parallel().tween_property(WorldSky, "sky_horizon_color", Color(1, 1, 0), DURATION_SKY_COLOR)
