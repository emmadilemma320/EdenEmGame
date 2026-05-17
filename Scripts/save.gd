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
const recipes_master_list = []
const NPC_LIST: Dictionary = {
	"chom bomb": "res://Resources/NPCs/characters/chom_bomb.tres", 
	"frog": "res://Resources/NPCs/characters/frog_prince.tres"
}

# grimoire progress
var discovered_collectables: Array[bool]
var discovered_recipes: Array[bool]

# town progress 
var discovered_npcs: Dictionary[String, int]

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta: float) -> void:
	pass

func new_save() -> void:
	discovered_collectables.resize(COLLECTABLE_LIST.keys().size())
	discovered_collectables.fill(false)
	
	discovered_recipes.resize(recipes_master_list.size())
	discovered_recipes.fill(false)
	
	discovered_npcs = {}
