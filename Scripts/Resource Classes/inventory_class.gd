extends Resource

class_name Inventory

signal update
signal player_drop(slot: InventorySlot)

@export var slots: Array[InventorySlot]
const STACK_LIMIT = 99

func _ready():
	for slot in slots:
		Global.discovered.append(slot.item.name)

#returns 0 if the item is successfully inserted, else returns a num of how much of the stack wasn't
func insert(item: InventoryCollectable, num: int) -> int:
	# if the num we are trying to add is less that our stack limit, we return false
	if num > STACK_LIMIT:
		print("attempted to pick up a stack of items, but the stack is too big!")
		return num
	if num <= 0:
		print("error: stack of size < 1!")
		return 0
	# going forward we can assume 0 < num <= STACK_LIMIT
	# looking for slots with our current item stored
	var itemslots = slots.filter(func(slot): return slot.item == item)
	# if we find (at least) one, we try to add our item to it/them
	if !itemslots.is_empty():
		var i:int = 0
		# iterate past the full slots until we find a non-full one or reach the end of the list
		while itemslots[i].amount >= STACK_LIMIT and i < (itemslots.size() - 1):
			i += 1
		# if we reach here and itemslots[i].amount < STACK_LIMIT, we know we have found one that is not empty (since them being full is a condition of the while loop)
		if itemslots[i].amount < STACK_LIMIT:
			# if there is enough space in our stack to take the whole stack we're trying to add, we add it all to the stack and signal to update, then return true 
			if(itemslots[i].amount + num <= STACK_LIMIT):
				itemslots[i].amount += num
				update.emit()
				return 0
			# if there is not enough space, we add what we can, then call insert() again on the remaining part of the stack
			# this will try to insert the rest of the stack, minus what we already added
			else:
				var temp_num = num - (STACK_LIMIT - itemslots[i].amount)
				itemslots[i].amount = STACK_LIMIT
				# call insert on the remaining that could not fit in the current stack
				return insert(item, temp_num)
	# if we have reached here that means there are no non-full slots of our item
	# so we look for empty slots instead
	var emptyslots = slots.filter(func(slot): return slot.item == null) # amount == 0?
	# if we find one, we add the stack to that slot
	if !emptyslots.is_empty():
		emptyslots[0].item = item
		emptyslots[0].amount = num
		update.emit()
		return 0
	# if not, we know our inventory is full
	print("inventory full")
	update.emit()
	return num
	
func trash(i: int, amt: int):
	slots[i].trash(amt)
	update.emit()
	
func drop(i: int, amt: int):
	if slots[i].amount < amt:
		amt = slots[i].amount
	#print("dropping ")
	player_drop.emit(slots[i], amt)
	trash(i, amt)
