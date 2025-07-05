class_name CollectableItem extends Area2D

@export var inventory_self: InventoryCollectable
@export var collection_message: String
var collision = CollisionShape2D.new()
#var sprite = Sprite2D.new()

func _init() -> void:
	collision.shape = CircleShape2D.new()
	collision.shape.radius = 4.0
	add_child(collision)
	
	#sprite.texture = inventory_self.texture
	#add_child(sprite)

func _on_body_entered(body: Node2D) -> void:
	body.collect(inventory_self)
	queue_free()
