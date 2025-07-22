extends Control
# The catalogue displays a list of all the different collectables the player has discovered, 
# including information about them such as recipes they can be used in, ways the turn them into potion ingrediants, etc.

const NPC_LIST: Dictionary = {
	
}

@onready var blank_entry = preload("res://Scenes/UI/Grimoire/catalogue_entry.tscn")
@onready var entries = $entries/grid1

# This tracks which collectables have been added since we last updated
var newly_discovered: Array[String]
var last_added: String

const BUFFER: int = 5

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	# We start with adding all pre-discovered collectables to the catalogue
	# (helpful for when building save files)
	update()

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass

func open():
	# we only update when it is opened to save processing time
	update()
	
	visible = true
	Global.current_open_menu.append(name)
	
func close():
	visible = false
	Global.current_open_menu.erase(name)

func update():
	# First we check what has been added since we last updated 
	
	# if the discovered array is empty or we're up to date, we skip updating
	print("Last added: ", last_added)
	if Global.discovered_collectables.size() == 0 or Global.discovered_collectables.back() == last_added:
		return
		
	# We iterate starting at the *back* of the discovered_collectables array 
	# (since collectables are added to the back when they are added)	
	for i in range(Global.discovered_collectables.size() - 1, -1, -1):
		print("Checking ", i, ": ", Global.discovered_collectables[i])
		if Global.discovered_collectables[i] == last_added:
			print("\tfound last added: ending loop")
			break
		else:
			print("\tadded to newly_discovered")
			newly_discovered.append(Global.discovered_collectables[i])
	
	for collectable_name in newly_discovered:
		# First we create a new entry for the collectable and populate it with data
		var new_entry = blank_entry.instantiate()
		
		new_entry.inventory_self = load(NPC_LIST[collectable_name])
		new_entry.update()
		
		if entries.get_children().size() == 0:
			print("First entry added: ", collectable_name, " of size ", new_entry.size)
			$entries/grid1.add_theme_constant_override("h_separation", int(new_entry.return_size().x) + BUFFER)
			$entries/grid1.add_theme_constant_override("v_separation", int(new_entry.return_size().y) + BUFFER)
			$entries/grid1.columns = int($entries/grid1.size.x / $entries/grid1.get_theme_constant("h_separation"))
		entries.add_child(new_entry)
		print(collectable_name, " added to catalogue")
	# i do not erase them inside the loop as that can cause issues when iterating
	
	#newly_discovered checks the discovered from back to front, so the first item in it is gonna 
	# be the back of discovered (or at least the 'most back' that it's checked)
	last_added = newly_discovered.front()
	newly_discovered.clear()
