class_name InventorySlot
extends Panel

@onready var texture_rect: AnimatedSprite2D = %TextureRect
@onready var stack_label : Label = %StackLabel

var item_data : ItemData = null

func set_item_data(new_item : ItemData, stack_size : int) -> void:
	item_data = new_item
	texture_rect.frame = item_data.item_texr
	set_current_stack_size(stack_size)

func set_current_stack_size(stack : int) -> void:
	if stack > 1:
		stack_label.show()
		stack_label.text = str(stack)
	else:
		stack_label.hide()
		return
