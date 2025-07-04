extends Area2D

@export var collectable: InventoryCollectable

func _on_body_entered(body: Node2D) -> void:
	print("berry nice!")
	body.collect(collectable)
	queue_free()
