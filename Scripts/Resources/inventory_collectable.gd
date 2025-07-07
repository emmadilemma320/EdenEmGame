extends Resource

#Resource (in-inventory) version of a collectable
class_name InventoryCollectable

@export var name: String = ""
@export var texture: Texture2D

func _to_string() -> String:
	return  name
