extends Area2D





func _on_body_entered(body: Node2D) -> void:
	if body is CharacterBody2D:
		print("player entered teleport trigger")
