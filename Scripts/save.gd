extends Node

# master list - could move to it's own 'game info' script just for constants
const COLLECTABLE_LIST: Dictionary = {
	"Amanita": "res://Resources/Collectables/amanita.tres", 
	"Apple": "res://Resources/Collectables/apple.tres", 
	"Berry": "res://Resources/Collectables/berry.tres", 
	"Blue Mushroom": "res://Resources/Collectables/blue_mushroom.tres",
	"Brown Mushroom": "res://Resources/Collectables/brown_mushroom.tres", 
	"Book": "res://Resources/Collectables/book.tres"
}
const RECIPE_LIST: Dictionary = {
	"recipe_name": "recipe_resource_path"
}
const NPC_LIST: Dictionary = {
	"chom bomb": "res://Resources/NPCs/characters/chom_bomb.tres", 
	"frog": "res://Resources/NPCs/characters/frog_prince.tres"
}

# grimoire progress - alphabetically by key
var discovered_collectables: Array[bool]
var discovered_recipes: Array[bool]

# town progress 
var discovered_npcs: Dictionary[String, int]

# Called when the node enters the scene tree for the first time.
func _ready() -> void:	
	# since we have not written the code for save files yet, so create a new save each time
	new_save()
	discovered_collectables[1] = true # i set one to discovered for testing
	
	# we set the catalogue_index value for each resource
	var collectable_keys = COLLECTABLE_LIST.keys()
	collectable_keys.sort() # first i take the list of keys and sort it
	for i in range(0, collectable_keys.size()):
		var curr_collectable : InventoryCollectable = load(COLLECTABLE_LIST[collectable_keys[i]])
		curr_collectable.set_catalogue_index(i)

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta: float) -> void:
	pass

func new_save() -> void:
	discovered_collectables.resize(COLLECTABLE_LIST.keys().size())
	discovered_collectables.fill(false)
	
	discovered_recipes.resize(RECIPE_LIST.keys().size())
	discovered_recipes.fill(false)
	
	discovered_npcs = {}
