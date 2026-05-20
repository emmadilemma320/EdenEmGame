extends Control
# The catalogue displays a list of all the different collectables the player has discovered, 
# including information about them such as recipes they can be used in, ways the turn them into potion ingrediants, etc.

@onready var blank_entry = preload("res://Scenes/UI/Grimoire/catalogue_entry.tscn")
@onready var entries = $entries/grid1

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
	var curr_index = 0
	print("Creating entry for ", collectable)
	
	if Save.discovered_collectables[curr_index]:
		reveal(curr_index)
	
func reveal(i: int) -> void:
	print("Entry ", i, " revealed!")

func open():
	visible = true
	
func close():
	visible = false
