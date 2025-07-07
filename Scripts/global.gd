extends Node

@export var player_inventory: Inventory
@export var discovered: Array[String]

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	discovered.append("amanita")
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
