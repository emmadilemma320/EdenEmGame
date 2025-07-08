extends Node

@export var discovered: Array[String]
@onready var current_scene = $"."
@onready var current_open_menu: Array[String]

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	discovered.append("amanita")
	current_open_menu.append("none")
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta: float) -> void:
	pass
