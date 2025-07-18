extends Area2D

@export var inventory_self: InventoryCollectable

@export var has_unique_sprite: bool

@onready var player
@onready var player_in_area
@export var amount: int = 1
const STACK_LIMIT: int = 99

#Sprites:
@onready var sprite: Sprite2D = $generic_sprite
@onready var label: Label = $Label
@onready var amount_label: Label = $item_amount

func _ready():
	label.text = inventory_self.name if Global.discovered_collectables.has(inventory_self.name) else "???"
	if has_unique_sprite:
		sprite.visible = false
	elif inventory_self.in_world_texture != null:
		sprite.texture = inventory_self.in_world_texture
		sprite.visible = true
	else:
		sprite.texture = inventory_self.texture
		sprite.visible = true
		
	amount_label.text = str(amount)
	if amount > 1:
		amount_label.visible = true

func _process(delta):
	if Global.discovered_collectables.has(inventory_self.name) and label.text != inventory_self.name:
		label.text = inventory_self.name
	if player_in_area and Input.is_action_just_pressed("item_pick_up"):
		# collect returns the amount from the stack that could not be added to player inventory
		# i.e. 0 if succuessfully added, 1 if 1 left, etc.
		amount = player.collect(inventory_self, amount)
		amount_label.text = str(amount)
		if amount <= 0:
			queue_free()
	if amount > STACK_LIMIT:
		amount = STACK_LIMIT
	
func _on_mouse_entered() -> void:
	label.visible = true
	amount_label.visible = false
	
	
func _on_mouse_exited() -> void:
	label.visible = false
	if amount > 1:
		amount_label.visible = true

func _on_body_entered(body: Node2D) -> void:
	player = body
	player_in_area = true
	
func _on_body_exited(body: Node2D) -> void:
	player_in_area = false
