extends BaseDialogueTestScene

func _ready() -> void:
	if Input.is_action_just_pressed("SpeechTest"):
		var ballon = load("res://scenes/balloon.tscn").instantiate()
		get_tree().current_scene.add_child(ballon)
		ballon.start(resource, title)
