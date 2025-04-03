extends Area2D
class_name Projectile

var direction:Vector2

signal delete_requested(projectile)

@export var speed : int

func _ready() -> void:
	set_physics_process(false)
	add_to_group("projectile")

func set_starting_values(starting_position: Vector2, direction_fire: Vector2):
	global_position = starting_position
	self.direction = direction_fire
	set_physics_process(true)

func _physics_process(delta: float) -> void:
	position += direction * speed * delta;
