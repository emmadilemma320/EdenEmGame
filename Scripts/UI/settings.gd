extends Control


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if Input.is_action_just_pressed("close_current_menu"):
		if Global.current_open_menu.has(name) and visible:
			close()
	
func open():
	visible = true
	Global.current_open_menu.append(name)
	
func close():
	visible = false
	Global.current_open_menu.erase(name)


func _on_settings_button_pressed() -> void:
	if visible:
		close()
	else:
		open()
