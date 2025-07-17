extends Node

var current_scene: String
var scenes: Dictionary
@onready var player = preload("res://Scenes/player.tscn")

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	scenes = {
		"Main Menu": "res://Scenes/UI/main_menu.tscn", 
		"World": "res://Scenes/Areas/world.tscn", 
		"Inside House": "res://Scenes/Areas/inside_house.tscn"
	}
	current_scene = "Main Menu"
	var scene_instance = load(scenes[current_scene]).instantiate()
	self.add_child(scene_instance)
	
	Global.scene_change_signal.connect(scene_change)
	


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass

func scene_change(next_scene: String, player_position: Vector2):
	# if the new scene is the same as the previous one, we do nothing
	print("beginning player teleport to ", next_scene)
	if next_scene == current_scene:
		return
	
	# delete any other scenes currently loaded in
	for child in get_children():
		child.queue_free()
	
	# create an instance of the scene and add it to self
	var scene_instance = load(scenes[next_scene]).instantiate()
	self.add_child(scene_instance)
	
	# create an instance of the player and place it in the scene at the given location
	var player_instance = player.instantiate()
	player_instance.position = player_position
	scene_instance.add_child(player_instance)
	
		
	
