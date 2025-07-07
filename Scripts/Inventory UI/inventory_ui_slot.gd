extends Panel

# nodes
@onready var item_visual: Sprite2D = $CenterContainer/Panel/item_display
@onready var amount_text: Label = $CenterContainer/Panel/stack_count
@onready var item_name: Label = $drop_down_menu/item_name
@onready var drop_down_menu: VBoxContainer = $drop_down_menu

@onready var buttons: Array
@onready var use: Button = $drop_down_menu/use_button
@onready var info: Button = $drop_down_menu/info_button
@onready var drop: Button = $drop_down_menu/drop_button
@onready var trash: Button = $drop_down_menu/trash_button

@onready var drop_down_open: bool = false
@export var inventory = self.get_parent()

# this runs when the inventory_ui signals that it is closing
# it handles any behavior that needs to happen when this happens 
# (for example closing any drop down menus)

func _ready():
	buttons = [use, info, drop, trash]

func closing():
	if drop_down_open:
		drop_down_menu.visible = false
		drop_down_open = false
		
func _on_drop_down_trigger_pressed() -> void:
	drop_down_menu.visible = false if drop_down_open else true
	drop_down_open = false if drop_down_open else true

func _on_drop_button_pressed() -> void:
	pass # Replace with function body.

func _on_trash_button_pressed() -> void:
	pass
	

func update(slot: InventorySlot):
	if !slot.item:
		item_visual.visible = false
		amount_text.visible = false
		item_name.text = "(empty)"
		for button in buttons:
			button.visible = false
	else:
		item_visual.visible = true
		item_visual.texture = slot.item.texture
		item_name.text = slot.item.name
		if slot.amount > 1:
			amount_text.visible = true
			amount_text.text = str(slot.amount)
		for button in buttons:
			button.visible = true
