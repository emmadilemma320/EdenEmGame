extends Control

signal open_game
@onready var scene_manager
const STARTING_WORLD_NAME: String = "World"
const PLAYER_STARTING_POSITION: Vector2 = Vector2(574.0, 327.0)

func _ready():
	scene_manager = get_parent()
	open_game.connect(scene_manager.scene_change)

func _on_start_button_pressed() -> void:
	open_game.emit(STARTING_WORLD_NAME, PLAYER_STARTING_POSITION)


func _on_exit_button_pressed() -> void:
	get_tree().quit()
