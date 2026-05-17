# master list - could move to it's own 'game info' script just for constants
const collectables_master_list = ["Apple", "Amanita"]
const recipes_master_list = []
const npc_master = ["Frog", "Chom Bomb"]

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
	discovered_collectables.resize(collectables_master_list.size())
	discovered_collectables.fill(false)
	
	discovered_recipes.resize(recipes_master_list.size())
	discovered_recipes.fill(false)
	
	discovered_npcs = {}
