extends CanvasLayer


@onready var inventory_ui: InventoryUI = %Inventory_UI
@onready var player: Player = %player

func _unhandled_input(event: InputEvent) -> void:
	if Input.is_action_just_pressed("inventory"):
		if inventory_ui.visible == false:
			inventory_ui.show()
			inventory_ui.populate_inventory(player.inventory_conponent)
			return
		else:
			inventory_ui.hide()
			
