class_name InventoryComponent

var inventory_contents : Dictionary = {}
signal update_inventory_ui

func check_inventory_contents(item: ItemData) -> bool:
	if inventory_contents.has(item):
		if inventory_contents[item] < item.item_stack_size:
			return true
		else:
			return false
	else:
		return true

func add_item(item : ItemData) -> void:
	if inventory_contents.has(item):
		if inventory_contents[item] < item.item_stack_size:
			inventory_contents[item] += 1
		else:
			return
	else:
		inventory_contents[item] = 1
	
	print(inventory_contents)
	update_inventory_ui.emit()
	
func get_inventory_contents() -> Dictionary:
	return inventory_contents
