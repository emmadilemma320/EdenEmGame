extends Control

@export var character: NPC
	
func update():
	
	if character != null:
		$nameplate/item_name.text = character.name
		$portrait_background/CenterContainer/item_portrait.texture = character.portrait
	else:
		print("Error setting character picture")
	
	
func return_size() -> Vector2:
	return Vector2($portrait_background.size.x + $description_background.size.x, $portrait_background.size.y + $nameplate.size.y)
