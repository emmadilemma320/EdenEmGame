extends Control

# Grimoire Buttons
@onready var grimoire_button_base: ColorRect = $grimoire_button_background

# Grimoire Elements
@onready var grimoire_base: ColorRect = $grimoire_base
@onready var table_of_contents: Label = $"grimoire_base/Table of Contents"

@onready var pages: Array
@onready var catalogue = $grimoire_base/pages/Catalogue
@onready var recipes = $grimoire_base/pages/recipes

@onready var page_button_ribbons: Array

# Dialogue scene
@onready var dialogue = $Dialogue

# Settings scene and button
@onready var settings = $Settings
@onready var settings_button: TextureButton = $"Settings Button"


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	# first we set our arrays
	#player_responses_buttons = player_responses_box.get_children()
	pages = $grimoire_base/pages.get_children()
	page_button_ribbons = $grimoire_base/grimoire_initial_image/page_buttons.get_children()
	
	# next we connect our signals
	Global.talk_to.connect(open_dialogue)
	Global.done_speaking.connect(close_dialogue)
	
	# next we close all menus, just in case
	close_grimoire()
	

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	# closing current ui menu via "close_current_menu"
	if Input.is_action_just_pressed("close_current_menu"):
		if Global.current_open_menu.back() == grimoire_base.name and grimoire_base.visible:
			close_grimoire()
		if Global.current_open_menu.back() == catalogue.name and catalogue.visible:
			close_grimoire_pages()
		if Global.current_open_menu.back() == recipes.name and recipes.visible:
			close_grimoire_pages()
	
	# opening & closing grimoire via "access_grimoire"
	if Input.is_action_just_pressed("access_grimoire") and !$Settings.visible:
		if grimoire_base.visible:
			close_grimoire()
		else:
			open_grimoire()
			
	if Input.is_action_just_pressed("access_catalogue") and grimoire_base.visible:			
		if catalogue.visible:
			close_grimoire_pages()
		else:
			open_grimoire_page(0)
			
	if Input.is_action_just_pressed("access_recipes") and grimoire_base.visible:
		if recipes.visible:
			close_grimoire_pages()
		else: 
			open_grimoire_page(1)
	


func _on_grimoire_button_pressed() -> void: # grimoire opening button
	if grimoire_base.visible:
		close_grimoire()
	else:
		open_grimoire()

func open_grimoire():
	grimoire_base.visible = true
	Global.current_open_menu.append(grimoire_base.name)
	
func close_grimoire():
	close_grimoire_pages()

	grimoire_base.visible = false
	Global.current_open_menu.erase(grimoire_base.name)
	
	
func open_dialogue(speaking_with: NPC):
	grimoire_button_base.visible = false
	#settings_button.visible = false
	
func close_dialogue():
	grimoire_button_base.visible = true
	

func open_grimoire_page(i: int):
	#ensure any open grimoire pages are closed
	close_grimoire_pages()
	
	# make the table of contents and any page buttons invisible
	table_of_contents.visible = false
	for button in page_button_ribbons:
		button.visible = false
	
	#open the requested page
	pages[i].open()
	
func close_grimoire_pages():
	table_of_contents.visible = true
	for button in page_button_ribbons:
		button.visible = true

	for page in pages:
		if page.visible:
			page.close()
	
