extends Resource

class_name NPC

# character info
@export var name: String
@export var texture: Texture2D

# character conversation (dictionary of Dialogue resources)
@export var conversations: Dictionary

func _to_string() -> String:
	return  name
