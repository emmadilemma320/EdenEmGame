extends Control

const SETTINGS_MENU_NAMES: Array = ["Visual Settings", "Audio Settings", "Gameplay Settings", "Credits"]

@onready var settings_label: Label = $Base/Label
@onready var main_settings_menu: VBoxContainer = $Base/main_settings_list
@onready var menus: Array

@onready var back_button: TextureButton = $Base/back_button


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	menus = $Base/menus.get_children()


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if Input.is_action_just_pressed("close_current_menu"):
		if Global.current_open_menu.back()==name and visible:
			close()
		for i in range(menus.size()):
			if Global.current_open_menu.back()==menus[i].name and menus[i].visible:
				close_settings_menus()
	
func open():
	visible = true
	Global.current_open_menu.append(name)
	
func close():
	visible = false
	for i in range(menus.size()):
		if menus[i].visible:
			close_settings_menus()
	Global.current_open_menu.erase(name)


func _on_settings_button_pressed() -> void:
	if visible:
		close()
	else:
		open()


func open_settings_menu(i: int):
	main_settings_menu.visible = false
	back_button.visible = true
	menus[i].visible = true
	settings_label.text = SETTINGS_MENU_NAMES[i]
	
	Global.current_open_menu.append(menus[i].name)
	
func close_settings_menus():
	main_settings_menu.visible = true
	back_button.visible = false
	for i in range(menus.size()):
		if menus[i].visible:
			menus[i].visible = false
			Global.current_open_menu.erase(menus[i].name)
	settings_label.text = "Settings"
	
	
