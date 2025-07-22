extends Control

@export var inventory_self: InventoryCollectable
	
func update():
	
	if inventory_self != null:
		$nameplate/item_name.text = inventory_self.name
		$portrait_background/CenterContainer/item_portrait.texture = inventory_self.texture
		#$portrait_background/item_portrait.texture.size = 
	else:
		print("Error setting inventory self")
	
	
func return_size() -> Vector2:
	return Vector2($portrait_background.size.x + $description_background.size.x, $portrait_background.size.y + $nameplate.size.y)
