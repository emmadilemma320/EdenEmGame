extends Area2D

@export var inventory_self: InventoryCollectable = preload("res://Resources/Inventory/Collectables/amanita.tres")

func _on_body_entered(body: Node2D) -> void:
	print("i won't have mush-room in my pack!")
	body.collect(inventory_self)
	queue_free()
