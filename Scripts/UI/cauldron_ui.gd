extends Panel

const potions: Dictionary = { # Temporary recipes, can change or delete later
	"Poison": ["Amanita"],
	"Energy": ["Apple", "Berry"],
	"Healing": ["Blue Mushroom"]
}

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	visible = false

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta: float) -> void:
	var open = await Global.cauldron_ui_open
	if open:
		open()
	else:
		close()

func open():
	visible = true

func close():
	visible = false

func _on_brew_pressed() -> void:
	pass # Replace with function body.
