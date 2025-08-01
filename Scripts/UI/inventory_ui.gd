extends Control

@onready var inventory: Inventory = preload("res://Resources/player_inventory.tres")
@onready var slots: Array = $NinePatchRect/GridContainer.get_children()


var is_open = false

func _ready():
	inventory.update.connect(update_slots)
	Global.get_gift.connect(open_gift_mode)
	Global.gift_is.connect(close_gift_mode)
	for i in range(slots.size()):
		slots[i].self_index = i
		
	Global.talking.connect(close)
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
	
func trash(slot_i: int, amount: int):
	inventory.trash(slot_i, amount)
	
func drop(slot_i: int, amount: int):
	inventory.drop(slot_i, amount)
	
func open_gift_mode():
	close() # first we close to ensure all menus & such are closed
	for slot in slots: # then we let the slots know we are in gifting mode
		slot.gifting_mode = true
	visible = true # then we make ourselves visible
	
func close_gift_mode(temp: String):
	visible = false
	for slot in slots: # then we let the slots know we are in gifting mode
		slot.gifting_mode = false
	
