extends Resource

class_name InventoryCollectable

@export var name: String = ""
@export var texture: Texture2D

func _to_string() -> String:
	return  name
