extends Node3D

@export var POSICOES : Array = [Vector3(0, 0, 0), Vector3(0, 0.2, 0)]
@export var DURATION : float = 5.0

func _ready() -> void:
	var tween = get_tree().create_tween()
	tween.set_loops()
	
	tween.tween_property(self, "position", POSICOES[1], DURATION)
	tween.tween_property(self, "position", POSICOES[0], DURATION)
