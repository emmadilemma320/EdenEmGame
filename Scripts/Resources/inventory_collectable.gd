extends Resource

#Resource (in-inventory) version of a collectable
class_name InventoryCollectable

@export var name: String = ""
@export var texture: Texture2D
@export var discovered: bool

func _to_string() -> String:
	return  name
