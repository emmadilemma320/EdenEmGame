extends Area2D

@export var inventory_self: InventoryCollectable = preload("res://Resources/Inventory/Collectables/berry.tres")

func _on_body_entered(body: Node2D) -> void:
	print("berry nice!")
	body.collect(inventory_self)
	queue_free()
