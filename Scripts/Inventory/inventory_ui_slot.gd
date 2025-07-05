extends Panel

@onready var item_visual: Sprite2D = $CenterContainer/Panel/item_display
@onready var amount_text: Label = $CenterContainer/Panel/stack_count
@onready var item_name: Label = $drop_down_menu/item_name
@onready var drop_down_menu: VBoxContainer = $drop_down_menu
@onready var drop_down_open: bool = false

@onready var inventory_ui = "Player/Inventory UI"


# this runs when the inventory_ui signals that it is closing
# it handles any behavior that needs to happen when this happens 
# (for example closing any drop down menus)
func closing():
	if drop_down_open:
		drop_down_menu.visible = false
		drop_down_open = false
	
func update(slot: InventorySlot):
	if !slot.item:
		item_visual.visible = false
		amount_text.visible = false
		item_name.text = "(empty)"
	else:
		item_visual.visible = true
		item_visual.texture = slot.item.texture
		item_name.text = slot.item.name
		if slot.amount > 1:
			amount_text.visible = true
			amount_text.text = str(slot.amount)

func _on_drop_down_trigger_pressed() -> void:
	drop_down_menu.visible = false if drop_down_open else true
	drop_down_open = false if drop_down_open else true
