extends Sprite2D

@onready var cannon:Sprite2D = $Cannon
@export var speed: float
@export var friction: float
@export var acceleration: float

var velocity: Vector2 = Vector2.ZERO
var projectile_container: Node

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _physics_process(delta: float) -> void:
	handle_movement(delta)
	handle_fire()
	
func handle_movement(delta: float) -> void:
	var direction:int = 0

	if Input.is_action_pressed("move_left"):
		direction = -1
	elif Input.is_action_pressed("move_right"):
		direction = 1

	if direction != 0:
		velocity.x = move_toward(velocity.x, direction * speed, acceleration * delta)
	else:
		velocity.x = move_toward(velocity.x, 0, friction * delta)

	position.x += velocity.x * delta

func set_projectile_container(container: Node):
	cannon.projectile_container = container
	projectile_container = container 
	
func handle_fire():
	var mouse_position = get_global_mouse_position()
	
	cannon.look_at(mouse_position)
	
	if Input.is_action_just_pressed("fire"):
		cannon.fire()
	
