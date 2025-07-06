extends Control

@onready var inventory: Inventory = preload("res://Resources/player_inventory.tres")
@onready var slots: Array = $NinePatchRect/GridContainer.get_children()

var is_open = false

func _ready():
	inventory.update.connect(update_slots)
	for i in range(slots.size()):
		slots[i].represents = inventory.slots[i]
	update_slots()
	close()
	
func _process(delta):
	if Input.is_action_just_pressed("open_inventory"):
		if is_open:
			close()
			for slot in slots:
				slot.closing()
		else:
			open()
			
	if Input.is_action_just_pressed("close_current_menu") and is_open:
		close()
		for slot in slots:
			slot.closing()

func update_slots():
	for i in range(min(inventory.slots.size(), slots.size())):
		slots[i].update(inventory.slots[i])

func open():
	visible = true
	is_open = true

func close():
	visible = false
	is_open = false
	
