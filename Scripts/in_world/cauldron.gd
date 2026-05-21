extends StaticBody2D

@onready var player
@onready var inventory: Inventory = preload("res://Resources/Inventories/player_inventory.tres")

signal cauldron_ui_open

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta: float) -> void:
	cauldron_ui_open.connect(Global.open_cauldron_ui)

func _on_button_pressed() -> void:
	cauldron_ui_open.emit()
