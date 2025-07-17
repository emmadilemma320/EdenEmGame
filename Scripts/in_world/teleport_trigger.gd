extends Area2D

@onready var scene_manager
@export var next_scene: String
@export var next_scene_player_positon: Vector2
signal teleport(String, Vector2)

func _ready():
	teleport.connect(Global.emit_scene_change_signal)

func _on_body_entered(body: Node2D) -> void:
	if body is CharacterBody2D:
		print("teleport speaking: initiated player teleport to ", next_scene)
		teleport.emit(next_scene, next_scene_player_positon)
		
