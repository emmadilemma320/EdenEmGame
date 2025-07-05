class_name CollectableItem extends Area2D

@export var inventory_self: InventoryCollectable
@export var collection_message: String
var collision = CollisionShape2D.new()
#var sprite = Sprite2D.new()
var label = Label.new()

func _init() -> void:
	collision.shape = CircleShape2D.new()
	collision.shape.radius = 4.0
	add_child(collision)
	
	#sprite.texture = inventory_self.texture
	#add_child(sprite)
	
	label.text = "berry"
	label.z_index = 1
	label.theme = preload("res://Assets/UI/Theme/in_world_theme.tres")
	add_child(label)

func _on_body_entered(body: Node2D) -> void:
	body.collect(inventory_self)
	queue_free()
	
func _on_mouse_entered() -> void:
	label.visible = true
	
func _on_mouse_exited() -> void:
	label.visible = false
