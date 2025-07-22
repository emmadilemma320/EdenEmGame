extends Control
# The catalogue displays a list of all the different npcs the player has discovered, 
# including information about them such as recipes they can be used in, ways the turn them into potion ingrediants, etc.

const NPC_LIST: Dictionary = {
	"chom bomb": "res://Resources/NPCs/chom_bomb.tres", 
	"frog": "res://Resources/NPCs/frog_prince.tres"
}

@onready var blank_entry = preload("res://Scenes/UI/Grimoire/address_book_entry.tscn")
@onready var entries = $entries/grid1

# This tracks which npcs have been added since we last updated
var newly_discovered: Array[String]
var last_added: String

const BUFFER: int = 5

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	# We start with adding all pre-discovered npcs to the catalogue
	# (helpful for when building save files)
	update()

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass

func open():
	# we only update when it is opened to save processing time
	update()
	
	visible = true
	
func close():
	visible = false

func update():
	# First we check what has been added since we last updated 
	
	# if the discovered array is empty or we're up to date, we skip updating
	print("Last added: ", last_added)
	if Global.discovered_npcs.size() == 0 or Global.discovered_npcs.back() == last_added:
		return
		
	# We iterate starting at the *back* of the discovered_npcs array 
	# (since npcs are added to the back when they are added)	
	for i in range(Global.discovered_npcs.size() - 1, -1, -1):
		print("Checking ", i, ": ", Global.discovered_npcs[i])
		if Global.discovered_npcs[i] == last_added:
			print("\tfound last added: ending loop")
			break
		else:
			print("\tadded to newly_discovered")
			newly_discovered.append(Global.discovered_npcs[i])
	
	for npc_name in newly_discovered:
		# First we create a new entry for the npc and populate it with data
		var new_entry = blank_entry.instantiate()
		
		new_entry.character = load(NPC_LIST[npc_name])
		new_entry.update()
		
		if entries.get_children().size() == 0:
			print("First entry added: ", npc_name, " of size ", new_entry.size)
			$entries/grid1.add_theme_constant_override("h_separation", int(new_entry.return_size().x) + BUFFER)
			$entries/grid1.add_theme_constant_override("v_separation", int(new_entry.return_size().y) + BUFFER)
			$entries/grid1.columns = int($entries/grid1.size.x / $entries/grid1.get_theme_constant("h_separation"))
		entries.add_child(new_entry)
		print(npc_name, " added to catalogue")
	# i do not erase them inside the loop as that can cause issues when iterating
	
	#newly_discovered checks the discovered from back to front, so the first item in it is gonna 
	# be the back of discovered (or at least the 'most back' that it's checked)
	last_added = newly_discovered.front()
	newly_discovered.clear()
