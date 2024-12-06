class_name InventoryUI
extends PanelContainer

@export var inventory_slot : PackedScene = null

@onready var grid_container: GridContainer = %GridContainer

func populate_inventory(inventory : InventoryComponent):
	clean_inventory()
	for item in inventory.get_inventory_contents():
		var new_slot = inventory_slot.instantiate() as InventorySlot
		grid_container.add_child(new_slot)
		new_slot.set_item_data(item, inventory.get_inventory_contents()[item])
		
	if inventory.update_inventory_ui.is_connected(populate_inventory):
		print("inv cont")
		return
	else:
		inventory.update_inventory_ui.connect(populate_inventory.bind(inventory))
		
func clean_inventory():
	for item_slot in grid_container.get_children():
		item_slot.queue_free() 

func _on_exit_button_button_down() -> void:
	clean_inventory()
	hide()
