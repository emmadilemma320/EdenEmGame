extends Resource

class_name InventorySlot

@export var item: InventoryCollectable
@export var amount: int

func trash():
	item = null
	amount = 0
