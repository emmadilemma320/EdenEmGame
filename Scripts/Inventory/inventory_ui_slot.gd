extends Panel

@onready var item_visual: Sprite2D = $CenterContainer/Panel/item_display
@onready var amount_text: Label = $CenterContainer/Panel/stack_count
@onready var item_name: Label = $CenterContainer/Panel/item_name_background/item_name
@onready var item_name_background: ColorRect = $CenterContainer/Panel/item_name_background

func update(slot: InventorySlot):
	if !slot.item:
		item_visual.visible = false
		amount_text.visible = false
		item_name.visible = false
		item_name_background.visible = false
		item_name.text = "(empty)"
		item_name_background.size = item_name.size
	else:
		item_visual.visible = true
		item_visual.texture = slot.item.texture
		item_name.text = slot.item.name
		item_name_background.size = item_name.size
		if slot.amount > 1:
			amount_text.visible = true
			amount_text.text = str(slot.amount)

func _on_mouse_entered() -> void:
	item_name_background.size = item_name.size
	item_name_background.visible = true
	item_name.visible = true

func _on_mouse_exited() -> void:
	item_name_background.visible = false
	item_name.visible = false
