extends Control
# The catalogue displays a list of all the different collectables the player has discovered, 
# including information about them such as recipes they can be used in, ways the turn them into potion ingrediants, etc.

@onready var blank_entry = preload("res://Scenes/UI/Grimoire/catalogue_entry.tscn")
@onready var entries = $entries/grid1

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass

func open():
	visible = true
	
func close():
	visible = false
