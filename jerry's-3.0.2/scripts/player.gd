class_name Player
extends CharacterBody2D


const SPEED = 130.0
const JUMP_VELOCITY = -300.0

@onready var timer: Timer = $Timer
@onready var atk_timer: Timer = $AtkTimer
@onready var animated_sprite: AnimatedSprite2D = $AnimatedSprite2D
@onready var MAIN_MENU = preload("res://scenes/MainMenu.tscn")
@onready var hit: Area2D = $hit
@onready var collision_shape: CollisionShape2D = $hit/hitarea
@onready var sprite: Sprite2D = $hit/hitarea/Sprite2D


var atk = false
var canatk = true
var inventory_conponent : InventoryComponent = InventoryComponent.new()

func _on_atk_timer_timeout() -> void:
	canatk = true
func _on_timer_timeout() -> void:
	atk = false
	hit.monitoring = false
	collision_shape.set_deferred("disabled", true)
	sprite.visible = false
func main() -> void:
	if Input.is_action_just_pressed("main"):
		get_tree().change_scene_to_file("res://scenes/MainMenu.tscn")
	if Input.is_action_pressed("jab") and atk == false and canatk == true:
		atk = true
		canatk = false
		timer.start()
		animated_sprite.play("jab")
		hit.monitoring = true
		collision_shape.set_deferred("disabled", false)
		atk_timer.start()
		sprite.visible = true
func _physics_process(delta: float) -> void:
	if not is_on_floor():
		velocity += get_gravity() * delta
	
	
	if Input.is_action_just_pressed("jump") and is_on_floor():
		velocity.y = JUMP_VELOCITY
		
	
	var direction := Input.get_axis("move_left", "move_right")
	if direction < 0:
		animated_sprite.flip_h = true
		collision_shape.position.x = -8
	elif direction > 0:
		animated_sprite.flip_h = false
		collision_shape.position.x = 8
	
	if atk == false:
		if is_on_floor():
			if direction == 0:
				animated_sprite.play("idle") 
			else:
				animated_sprite.play("run")
		else:
			animated_sprite.play("jump")
		
	
	if direction:
		velocity.x = direction * SPEED
	else:
		velocity.x = move_toward(velocity.x, 0, SPEED)
		
	main()
	move_and_slide()
