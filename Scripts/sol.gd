extends DirectionalLight3D

@onready var WorldEnvironmentScene : Environment = %WorldEnvironment.environment
@onready var SkyMaterial : ProceduralSkyMaterial = WorldEnvironmentScene.sky.sky_material
const DURATION_SON : float = 10.0
const DURATION_SKY_COLOR : float = DURATION_SON * 0.9
const DURATION_ANOITECER : float = 5
const POS_FINAL_SOL : Vector3 = Vector3(-180, 0, 0)
const COR_POR_SOL : Color = Color(1, 1, 0)
const ENERGY_LIGTH_ANOITECER : float = 0.03
const COR_CEU_ANOITECER_1 : Color = Color(0.3, 0.3, 0.3)
const COR_CEU_ANOITECER_2 : Color = Color(0, 0, 0.4)

func _ready() -> void:
	var tween_sol := get_tree().create_tween()
	var tween_ceu := get_tree().create_tween()
	
	tween_sol.tween_property(self, "rotation_degrees", POS_FINAL_SOL, DURATION_SON)
	tween_ceu.tween_property(SkyMaterial, "sky_horizon_color", COR_POR_SOL, DURATION_SKY_COLOR)

	tween_sol.finished.connect(_anoitecer)
	
func _anoitecer():
	var tween_anoitecer_sol := get_tree().create_tween()
	var tween_anoitecer_ceu := get_tree().create_tween()
	
	visible = false
	
	tween_anoitecer_sol.tween_property(self, "light_energy", ENERGY_LIGTH_ANOITECER, DURATION_ANOITECER)
	tween_anoitecer_ceu.tween_property(WorldEnvironmentScene, "ambient_light_energy", ENERGY_LIGTH_ANOITECER, DURATION_ANOITECER)
	tween_anoitecer_ceu.parallel().tween_property(SkyMaterial, "sky_horizon_color", COR_CEU_ANOITECER_1, DURATION_ANOITECER)
	tween_anoitecer_ceu.parallel().tween_property(SkyMaterial, "sky_top_color", COR_CEU_ANOITECER_2, DURATION_ANOITECER)
