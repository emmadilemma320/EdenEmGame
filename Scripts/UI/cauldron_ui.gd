extends Panel

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta: float) -> void:
	var open = await Global.cauldron_ui_open
	if open:
		open()
	else:
		close()

func open():
	visible = true
	pass

func close():
	visible = false
	pass
