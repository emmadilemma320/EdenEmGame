extends Control

@onready var grimoire_button_base: ColorRect = $grimoire_button_background

@onready var grimoire_base: ColorRect = $grimoire_base
var grimoire_open: bool

@onready var dialogue_base: ColorRect = $dialogue_base
var dialogue_open: bool



# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	close_grimoire()
	close_dialogue()


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	# closing current ui menu via "close_current_menu"
	if Input.is_action_just_pressed("close_current_menu"):
		if Global.current_open_menu.back() == grimoire_base.name and grimoire_open:
			close_grimoire()
		if Global.current_open_menu.back() == dialogue_base.name and dialogue_open:
			close_dialogue()
	
	# opening & closing grimoire via "access_grimoire"
	if Input.is_action_just_pressed("access_grimoire"):
		if grimoire_open:
			close_grimoire()
		else:
			open_grimoire()
			
	if Global.player_is_speaking:
		open_dialogue()
	


func _on_button_pressed() -> void:
	if grimoire_open:
		close_grimoire()
	else:
		open_grimoire()

func open_grimoire():
	grimoire_base.visible = true
	grimoire_open = true
	Global.current_open_menu.append(grimoire_base.name)
	
func close_grimoire():
	grimoire_base.visible = false
	grimoire_open = false
	Global.current_open_menu.erase(grimoire_base.name)
	
func open_dialogue():
	dialogue_base.visible = true
	dialogue_open = true
	grimoire_button_base.visible = false
	Global.current_open_menu.append(dialogue_base.name)
	
func close_dialogue():
	Global.player_is_speaking = false # replace with send a signal
	dialogue_base.visible = false
	dialogue_open = false
	grimoire_button_base.visible = true
	Global.current_open_menu.erase(dialogue_base.name)
