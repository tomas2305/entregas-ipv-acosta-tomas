extends CharacterBody2D

@onready var weapon: Node = $"%Weapon"
@onready var body_animations: AnimationPlayer = $BodyAnimations
@onready var body_pivot: Node2D = $BodyPivot

const FLOOR_NORMAL: Vector2 = Vector2(0, -1)
const SNAP_LENGHT: float = 32.0
const SLOPE_THRESHOLD: float = deg_to_rad(46)

@export var ACCELERATION: float = 60.0
@export var H_SPEED_LIMIT: float = 600.0
@export var jump_speed: int = 500
@export var FRICTION_WEIGHT: float = 0.1
@export var gravity: int = 10

var projectile_container: Node
var dead: bool = false

func _ready() -> void:
	initialize()

func initialize(projectile_container: Node = get_parent()) -> void:
	self.projectile_container = projectile_container
	weapon.projectile_container = projectile_container

func _process_input() -> void:
	if dead:
		velocity.x = lerp(velocity.x, 0.0, FRICTION_WEIGHT) if abs(velocity.x) > 1.0 else 0.0
		return
	
	if Input.is_action_just_pressed("fire_cannon"):
		if projectile_container == null:
			projectile_container = get_parent()
		if weapon.projectile_container == null:
			weapon.projectile_container = projectile_container
		weapon.fire()

	if Input.is_action_just_pressed("jump") and is_on_floor():
		velocity.y = -jump_speed

	var h_movement_direction: int = int(Input.is_action_pressed("move_right")) - int(Input.is_action_pressed("move_left"))
	if h_movement_direction != 0:
		velocity.x = clamp(velocity.x + (h_movement_direction * ACCELERATION), -H_SPEED_LIMIT, H_SPEED_LIMIT)
		body_pivot.scale.x = 1 - 2 * float(h_movement_direction < 0)		
	else:
		velocity.x = lerp(velocity.x, 0.0, FRICTION_WEIGHT) if abs(velocity.x) > 1.0 else 0.0
	
	
	
	if !is_on_floor():
		body_animations.play("jump")
	elif h_movement_direction != 0:
		body_animations.play("walk")
	else:
		body_animations.play("idle")
		
	
	weapon.process_input()

func _physics_process(delta: float) -> void:
	_process_input()
	velocity.y += gravity
	move_and_slide()

func notify_hit() -> void:
	print("I'm player and imma die")
	call_deferred("_remove")

func _remove() -> void:
	set_physics_process(false)
	hide()
	collision_layer = 0

func _play_animation(animation: String) -> void:
	pass
