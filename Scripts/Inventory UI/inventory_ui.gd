extends Control

@onready var inventory: Inventory = preload("res://Resources/player_inventory.tres")
@onready var slots: Array = $NinePatchRect/GridContainer.get_children()


var is_open = false

func _ready():
	inventory.update.connect(update_slots)
	for i in range(slots.size()):
		slots[i].self_index = i
	update_slots()
	close()
	
func _process(delta):
	if Input.is_action_just_pressed("open_inventory"):
		if is_open:
			close()
		else:
			open()
			
	if Input.is_action_just_pressed("close_current_menu") and Global.current_open_menu.back() == name:
		if is_open:
			close()

func update_slots():
	for i in range(min(inventory.slots.size(), slots.size())):
		slots[i].update(inventory.slots[i])

func open():
	visible = true
	is_open = true
	Global.current_open_menu.append(name)

func close():
	for slot in slots:
		slot.close_drop_down()
	visible = false
	is_open = false
	Global.current_open_menu.erase(name)
	
func trash(slot_i: int):
	inventory.trash(slot_i)
	
func drop(slot_i: int):
	inventory.drop(slot_i)
