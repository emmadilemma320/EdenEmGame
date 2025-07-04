extends Resource

class_name Inventory

signal update

@export var slots: Array[InventorySlot]
const STACK_LIMIT = 99

func insert(item: InventoryCollectable):
	var itemslots = slots.filter(func(slot): return slot.item == item)
	if !itemslots.is_empty():
		# to make it automatically make a new stack on 99+:
		# var i = 0
		# while  itemslots[0].amount >= STACK_LIMIT
		#		i += 1
		#		if i > itemslots.size()
					#break (?)
		itemslots[0].amount += 1
		print("added item to existing stack in inventory")
		
	else:
		var emptyslots = slots.filter(func(slot): return slot.item == null)
		if !emptyslots.is_empty():
			print("added item to new stack in inventory")
			emptyslots[0].item = item
			emptyslots[0].amount = 1
		else:
			print("inventory full!")
	update.emit()
