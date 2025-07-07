extends Resource

class_name Inventory

signal update

@export var slots: Array[InventorySlot]
const STACK_LIMIT = 99

#returns true if the item is successfully inserted
func insert(item: InventoryCollectable) -> bool:
	var itemslots = slots.filter(func(slot): return slot.item == item)
	if !itemslots.is_empty():
		var i:int = 0
		while itemslots[i].amount >= STACK_LIMIT and i < (itemslots.size() - 1):
			i += 1
		if itemslots[i].amount < STACK_LIMIT:
			itemslots[i].amount += 1
			update.emit()
			return true
	var emptyslots = slots.filter(func(slot): return slot.item == null) # amount == 0?
	if !emptyslots.is_empty():
		emptyslots[0].item = item
		emptyslots[0].amount = 1
		update.emit()
		return true
	return false
	
