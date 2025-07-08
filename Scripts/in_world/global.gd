extends Node

@export var discovered: Array[String]
@onready var current_scene = $"."
@onready var current_open_menu: Array[String]

#TEMPORARY
@export var player_is_speaking: bool

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	discovered.append("amanita")
	#discovered.append("chom bomb")
	current_open_menu.append("none")
	player_is_speaking = false


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta: float) -> void:
	pass
	
# copy-paste into code when you wish to use it
func wait(seconds: float) -> void:
	await get_tree().create_timer(seconds).timeout
