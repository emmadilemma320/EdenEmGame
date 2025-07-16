extends Panel

# nodes
@onready var item_visual: Sprite2D = $CenterContainer/Panel/item_display
@onready var amount_text: Label = $CenterContainer/Panel/stack_count
@onready var item_name: Label = $drop_down_menu/item_name
@onready var drop_down_menu: VBoxContainer = $drop_down_menu

# buttons in drop-down
@onready var buttons: Array
@onready var use: Button = $drop_down_menu/use_button
@onready var info: Button = $drop_down_menu/info_button
@onready var drop: Button = $drop_down_menu/drop_button
@onready var trash: Button = $drop_down_menu/trash_button

#item drop line edit
@onready var drop_amount_line: LineEdit = $drop_down_menu/drop_button/amount_edit
@onready var trash_amount_line: LineEdit = $drop_down_menu/trash_button/amount_edit

@onready var drop_down_open: bool = false
@onready var inventory_ui = self.get_parent().get_parent().get_parent()
@onready var self_index: int # it's own index in the list of slots

# this runs when the inventory_ui signals that it is closing
# it handles any behavior that needs to happen when this happens 
# (for example closing any drop down menus)

func _ready():
	buttons = [use, info, drop, trash]
	
func _process(delta):
	if Input.is_action_just_pressed("close_current_menu") and Global.current_open_menu.back() == name:
		if drop_down_open:
			close_drop_down()
	if Global.current_open_menu.back() != name:
		close_drop_down()

		
func _on_drop_down_trigger_pressed() -> void:
	if drop_down_open:
		close_drop_down()
	else:
		open_drop_down()

func _on_drop_button_pressed() -> void:
	drop_amount_line.visible = true
	var amount: int = int(await drop_amount_line.text_submitted)
	
	drop_amount_line.visible = false
	drop_amount_line.text = ""
	
	inventory_ui.drop(self_index, amount)
	close_drop_down()

func _on_trash_button_pressed() -> void:
	trash_amount_line.visible = true
	var amount: int = int(await trash_amount_line.text_submitted)
	
	trash_amount_line.visible = false
	trash_amount_line.text = ""
	
	inventory_ui.trash(self_index, amount)
	close_drop_down()

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
		amount_text.text = str(slot.amount)
		amount_text.visible = (slot.amount > 1)

		for button in buttons:
			button.visible = true

func close_drop_down():
	Global.current_open_menu.erase(name)
	drop_down_menu.visible = false
	drop_amount_line.visible = false
	trash_amount_line.visible = false
	drop_down_open = false

func open_drop_down():
	Global.current_open_menu.append(name)
	drop_down_menu.visible = true
	drop_down_open = true


func _on_drop_amount_edit_text_changed(new_text: String) -> void:
	if int(new_text) > int(amount_text.text):
		drop_amount_line.text = amount_text.text


func _on_trash_amount_edit_text_changed(new_text: String) -> void:
	if int(new_text) > int(amount_text.text):
		trash_amount_line.text = amount_text.text
