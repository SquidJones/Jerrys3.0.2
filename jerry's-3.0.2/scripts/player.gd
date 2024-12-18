class_name Player
extends CharacterBody2D


const SPEED = 130.0
const DASH_SPEED = 260.0
const JUMP_VELOCITY = -300.0

@onready var damage_area: CollisionShape2D = $DamageArea
@onready var timer: Timer = $Timer
@onready var atk_timer: Timer = $AtkTimer
@onready var animated_sprite: AnimatedSprite2D = $AnimatedSprite2D
@onready var MAIN_MENU = preload("res://scenes/MainMenu.tscn")
@onready var hit: Area2D = $hit
@onready var collision_shape: CollisionShape2D = $hit/hitarea
@onready var sprite: Sprite2D = $hit/hitarea/Sprite2D
@onready var actionable_finder: CollisionShape2D = $Direction/ActionableFinder/ActionableFinder
@onready var actionable_finderArea: Area2D = $Direction/ActionableFinder

var atk = false
var canatk = true
var inventory_conponent : InventoryComponent = InventoryComponent.new()
var jump_count = 0
var max_jumps = 2
var dashing = false
var can_dash = true

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
		
func _unhandled_input(event: InputEvent) -> void:
	if Input.is_action_just_pressed("SpeechTest"):
		var actionables = actionable_finderArea.get_overlapping_areas()
		if actionables.size() > 0:
			actionables[0].action()
			return
	
func _physics_process(delta: float) -> void:
	if not is_on_floor():
		velocity += get_gravity() * delta
	elif is_on_floor():
		jump_count = 0
	
	
	if Input.is_action_just_pressed("jump") and jump_count < max_jumps:
		jump_count += 1
		velocity.y = JUMP_VELOCITY
	
	if Input.is_action_just_pressed("dash") and can_dash == true:
		dashing = true
		can_dash = false
		damage_area.disabled = true
		await get_tree().create_timer(0.2).timeout
		dashing = false
		damage_area.disabled = false
		await get_tree().create_timer(5).timeout
		can_dash = true

	
	var direction := Input.get_axis("move_left", "move_right")
	if direction < 0:
		animated_sprite.flip_h = true
		collision_shape.position.x = -8
		actionable_finder.position.x = -8
	elif direction > 0:
		animated_sprite.flip_h = false
		collision_shape.position.x = 8
		actionable_finder.position.x = 8
	
	if atk == false:
		if is_on_floor():
			if direction == 0:
				animated_sprite.play("idle") 
			else:
				animated_sprite.play("run")
		else:
			animated_sprite.play("jump")
		
	
	if direction:
		if dashing == true:
			velocity.x = direction * DASH_SPEED
		else:
			velocity.x = direction * SPEED
	else:
		velocity.x = move_toward(velocity.x, 0, SPEED)
		
	main()
	move_and_slide()
