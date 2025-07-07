extends Control

@onready var grimoire_base: ColorRect = $grimoire_base
var grimoire_open: bool

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	close_grimoire()


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if Input.is_action_just_pressed("close_current_menu") and Global.current_open_menu.back() == name:
		if grimoire_open:
			close_grimoire()
	if Input.is_action_just_pressed("access_grimoire"):
		if grimoire_open:
			close_grimoire()
		else:
			open_grimoire()


func _on_button_pressed() -> void:
	if grimoire_open:
		close_grimoire()
	else:
		open_grimoire()

func open_grimoire():
	grimoire_base.visible = true
	grimoire_open = true
	Global.current_open_menu.append(name)
	
func close_grimoire():
	grimoire_base.visible = false
	grimoire_open = false
	Global.current_open_menu.erase(name)
	
