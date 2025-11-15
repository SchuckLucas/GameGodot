extends OmniLight3D

@export var energy = 2
var lanterna_ligada = false

func _process(_delta: float) -> void:
	if Input.is_action_just_pressed("ui_lanterna"):
		lanterna_ligada = not lanterna_ligada
		
		if lanterna_ligada:
			light_energy = energy
		else:
			light_energy = 0
