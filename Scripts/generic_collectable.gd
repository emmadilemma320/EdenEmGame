extends Area2D

@export var inventory_self: InventoryCollectable
@onready var player
@onready var player_in_area

#Sprites:
@onready var sprite: Sprite2D = $Sprite2D
@onready var label: Label = $Label

func _ready():
	label.text = inventory_self.name if Global.discovered.has(inventory_self.name) else "???"
	sprite.texture = inventory_self.texture
	
func _process(delta):
	if Global.discovered.has(inventory_self.name):
		label.text = inventory_self.name
	if player_in_area and Input.is_action_pressed("item_pick_up"):
		if player.collect(inventory_self):
			queue_free()
	
func _on_mouse_entered() -> void:
	label.visible = true
	
func _on_mouse_exited() -> void:
	label.visible = false

func _on_body_entered(body: Node2D) -> void:
	player = body
	player_in_area = true
	
func _on_body_exited(body: Node2D) -> void:
	player_in_area = false
