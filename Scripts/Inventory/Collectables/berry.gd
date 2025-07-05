extends Area2D

@export var inventory_self: InventoryCollectable = preload("res://Resources/Inventory/Collectables/berry.tres")
@onready var name_label: Label = $name
@onready var player
@onready var player_in_area: bool

func _process(delta):
	if player_in_area and Input.is_action_pressed("item_pick_up"):
		print("berry nice!")
		player.collect(inventory_self)
		queue_free()
	
func _on_mouse_entered() -> void:
	name_label.visible = true
	
func _on_mouse_exited() -> void:
	name_label.visible = false

func _on_body_entered(body: Node2D) -> void:
	player = body
	player_in_area = true
	
func _on_body_exited(body: Node2D) -> void:
	player_in_area = false
