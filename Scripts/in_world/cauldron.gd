extends StaticBody2D

@onready var player
@onready var inventory: Inventory = preload("res://Resources/Inventories/player_inventory.tres")

var is_open = false

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if Input.is_action_just_pressed("item_pick_up"):
		open()

func open():
	is_open = true
