extends Control
# The catalogue displays a list of all the different collectables the player has discovered, 
# including information about them such as recipes they can be used in, ways the turn them into potion ingrediants, etc.

@onready var blank_entry = preload("res://Scenes/UI/Grimoire/catalogue_entry.tscn")
@onready var entries = $entries/grid1

const ENTRY_BUFFER = -20
var max_entries_per_page: Vector2 = Vector2(1, 1)

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	# To start, we make a list of all collectables (not just the discovered ones)
	# and sort it alphabetically
	var all_collectables = Save.COLLECTABLE_LIST.keys()
	all_collectables.sort()
	
	# Then we create an entry for each collectable
	for collectable in all_collectables:
		create_entry(collectable)
	

func create_entry(collectable: String) -> void:
	var curr_index = entries.get_children().size()
	print("Creating entry for ", collectable, " at index ", curr_index)
	
	var new_entry = blank_entry.instantiate()
	new_entry.inventory_self = load(Save.COLLECTABLE_LIST[collectable])
	new_entry.update()
	
	if entries.get_children().size() == 0:
		entries.add_theme_constant_override("h_separation", int(new_entry.return_size().x) + ENTRY_BUFFER)
		entries.add_theme_constant_override("v_separation", int(new_entry.return_size().y) + ENTRY_BUFFER)
		max_entries_per_page[0] = int(entries.size.x) / entries.get_theme_constant("h_separation")
		max_entries_per_page[1] = int(entries.size.y) / entries.get_theme_constant("v_separation")
		print(max_entries_per_page)
	if curr_index + 1 > max_entries_per_page.y:
		print("Collectable ", collectable, " extends off of page!")
		
	if Save.discovered_collectables[curr_index]:
		new_entry.reveal()
		
	entries.add_child(new_entry)

func open():
	visible = true
	
func close():
	visible = false
