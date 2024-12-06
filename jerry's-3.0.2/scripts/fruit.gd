extends Area2D

@export var collectable_data : ItemData = null
@onready var animated_sprite_2d: AnimatedSprite2D = $AnimatedSprite2D

func _ready() -> void:
	animated_sprite_2d.set_frame(collectable_data.item_texr)

func _on_body_entered(body: Node2D) -> void:
	if body is Player:
		print(" found: " + collectable_data.item_name)
		if body.inventory_conponent.check_inventory_contents(collectable_data) == true:
			body.inventory_conponent.add_item(collectable_data)
			if collectable_data.item_ID == 000 and State.apple_status == "none":
				State.apple_status = "has"
			queue_free()
		else:
			print("fuck off")
