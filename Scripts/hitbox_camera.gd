extends Area3D

@onready var Camera : Camera3D = %Camera
const TRANPARENCY = 0.8

func _on_body_entered(body: Node3D) -> void:
	if Camera.camera == -1:
		var mesh : MeshInstance3D = get_mesh(body)
		mesh.transparency = TRANPARENCY


func _on_body_exited(body: Node3D) -> void:
	if Camera.camera == -1:
		var mesh : MeshInstance3D = get_mesh(body)
		mesh.transparency = 0

func get_mesh(body : Node3D):
	for child in body.get_children():
		if child is MeshInstance3D:
			return child
