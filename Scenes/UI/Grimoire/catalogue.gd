extends Control


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass

func open():
	visible = true
	Global.current_open_menu.append(name)
	
func close():
	visible = false
	Global.current_open_menu.erase(name)
