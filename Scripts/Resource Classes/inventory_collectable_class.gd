extends Resource

#Resource (in-inventory) version of a collectable
class_name InventoryCollectable

@export_category("Basic Info")
@export var name: String = ""

@export_category("Textures")
@export var texture: Texture2D
@export var in_world_texture: Texture2D

func _to_string() -> String:
	return name

func return_name() -> String:
	return name
