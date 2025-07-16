extends Resource

class_name InventorySlot

@export var item: InventoryCollectable
@export var amount: int

func trash(amt: int):
	amount -= amt
	if amount <= 0:
		item = null
		amount = 0
		#print("no items now")
