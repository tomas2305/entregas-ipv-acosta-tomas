extends StaticBody2D

@onready var fire_position: Node2D = $FirePosition
@onready var fire_timer: Timer = $FireTimer
@onready var raycast: RayCast2D = $RayCast2D
@onready var body_anim: AnimatedSprite2D = $Body

@export var projectile_scene: PackedScene

var target: Node2D
var projectile_container: Node

## Flag de ayuda para saber identificar el estado de actividad
var dead: bool = false


func _ready() -> void:
	fire_timer.timeout.connect(fire)  ## Estilo Godot 4 moderno
	set_physics_process(false)
	_play_animation("idle")
		


func initialize(container: Node, turret_pos: Vector2, projectile_container: Node) -> void:
	container.add_child(self)
	global_position = turret_pos
	self.projectile_container = projectile_container


func fire() -> void:
	if target != null:
		var proj_instance = projectile_scene.instantiate()
		if projectile_container == null:
			projectile_container = get_parent()
		proj_instance.initialize(projectile_container, fire_position.global_position, fire_position.global_position.direction_to(target.global_position))
		projectile_container.add_child(proj_instance)
		fire_timer.start()


func _physics_process(delta: float) -> void:
	if target == null:
		return

	raycast.target_position = to_local(target.global_position)
	
	if raycast.is_colliding() and raycast.get_collider() == target:
		if fire_timer.is_stopped():
			fire_timer.start()
	else:
		if not fire_timer.is_stopped():
			fire_timer.stop()


func notify_hit() -> void:
	print("I'm turret and imma die")
	# Aquí podrías reproducir una animación y luego llamar a _remove()


func _remove() -> void:
	queue_free()


func _on_DetectionArea_body_entered(body: Node) -> void:
	if target == null:
		target = body
		set_physics_process(true)


func _on_DetectionArea_body_exited(body: Node) -> void:
	if body == target:
		target = null
		set_physics_process(false)


func _on_animation_finished() -> void:
	pass


func _play_animation(animation: String) -> void:
	if body_anim.sprite_frames.has_animation(animation):
		body_anim.play(animation)
