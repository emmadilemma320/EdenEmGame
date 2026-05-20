extends Control
# The catalogue displays a list of all the different collectables the player has discovered, 
# including information about them such as recipes they can be used in, ways the turn them into potion ingrediants, etc.

@onready var blank_entry = preload("res://Scenes/UI/Grimoire/catalogue_entry.tscn")
@onready var entries = $entries
@onready var current_page = $entries/grid1
var current_page_num = 0

const RIGHT_PAGE_POSITION = 480
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
	current_page_num = 0
	current_page = entries.get_child(0)
	

func create_entry(collectable: String) -> void:
	var curr_index = current_page.get_children().size()
	
	var new_entry = blank_entry.instantiate()
	new_entry.inventory_self = load(Save.COLLECTABLE_LIST[collectable])
	new_entry.update()
	
	if Save.discovered_collectables[curr_index]:
		new_entry.reveal()
	
	if current_page_num == 0 and current_page.get_children().size() == 0:
		current_page.add_theme_constant_override("h_separation", int(new_entry.return_size().x) + ENTRY_BUFFER)
		current_page.add_theme_constant_override("v_separation", int(new_entry.return_size().y) + ENTRY_BUFFER)
		max_entries_per_page[0] = int(current_page.size.x) / current_page.get_theme_constant("h_separation")
		max_entries_per_page[1] = int(current_page.size.y) / current_page.get_theme_constant("v_separation")
		print(max_entries_per_page)
	
	if curr_index + 1 > max_entries_per_page.y:
		# if our entries could extend off the page, we create a new page to add them too
		# first we create a new GridContainer to be the page
		var new_page = GridContainer.new()
		print("Collectable ", collectable, " extends off of page!")
		print("Moving to page ", current_page_num+1)
		
		# next we set the horizontal and vertical separation to match our calculated values
		new_page.add_theme_constant_override("h_separation", current_page.get_theme_constant("h_separation"))
		new_page.add_theme_constant_override("v_separation", current_page.get_theme_constant("v_separation"))
		
		# we increment the page number and determine if this new page is a left or right page
		current_page_num += 1
		entries.add_child(new_page)
		
		if current_page_num % 1 == 0:
			# if it is a right page, we move it to the right side 
			print("This is a right page")
			new_page.position.x += RIGHT_PAGE_POSITION
			
		# if the current page is > 1, it is default invisible, since the catalogue starts on pages 0,1
		if current_page_num > 1:
			new_page.visible = false
		
		# finally, we add the new page to the scene, increment the page number, and update the current_page variable
		
		current_page = new_page
		
		
	current_page.add_child(new_entry)
	print("Created entry for ", collectable, " at index ", curr_index, " on page ", current_page_num)
	

func open():
	visible = true
	
func close():
	visible = false
