extends Area3D

@onready var Player : CharacterBody3D = get_parent()

func _on_body_entered(_body: Node3D) -> void:
	Player.nadando = true

func _on_body_exited(_body: Node3D) -> void:
	Player.nadando = false
