extends Resource

#Resource (in-inventory) version of a collectable
class_name InventoryCollectable

@export_category("Basic Info")
@export var name: String = ""
@export_enum("Ingrediant", "Processed", "Consumable") var type: int
var catalogue_index = -1

@export_category("Textures")
@export var texture: Texture2D
@export var in_world_texture: Texture2D
	
func get_catalogue_index() -> int:
	if catalogue_index == -1:
		#print("\tcatalogue index of ", name, " unset!")
		var keys: Array = Save.COLLECTABLE_LIST.keys()
		keys.sort()
		catalogue_index = keys.find(name)
		#print("\tcatalogue index set to ", catalogue_index)
	return catalogue_index 

func set_catalogue_index(index: int):
	catalogue_index = index

func _to_string() -> String:
	return name

func return_name() -> String:
	return name
