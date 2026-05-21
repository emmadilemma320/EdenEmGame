extends Control

@export var inventory_self: InventoryCollectable

func set_portrait():
	if inventory_self == null:
		return
	$portrait_background/CenterContainer/item_portrait.texture = inventory_self.texture
	
func reveal():
	$nameplate/item_name.text = inventory_self.name
	$portrait_background/CenterContainer/item_portrait.visible = true
	print("Entry ", inventory_self.name, " revealed!")
	
func return_size() -> Vector2:
	return Vector2($portrait_background.size.x + $description_background.size.x, $portrait_background.size.y + $nameplate.size.y)
