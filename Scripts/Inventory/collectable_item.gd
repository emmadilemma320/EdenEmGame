class_name CollectableItem extends Area2D

@export var inventory_self: InventoryCollectable
@export var collection_message: String


func _on_body_entered(body: Node2D) -> void:
	print(collection_message)
	body.collect(inventory_self)
	queue_free()
