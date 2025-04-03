extends Sprite2D

@onready var fire_position: Marker2D = $FirePosition

@export var projectile_scene : PackedScene

var projectile_container: Node2D

func fire():
	var projectile_instance : Projectile = projectile_scene.instantiate()
	var direction : Vector2 = (fire_position.global_position - global_position).normalized()

	projectile_container.add_child(projectile_instance)
	projectile_instance.set_starting_values(fire_position.global_position, direction)
	projectile_instance.delete_requested.connect(_on_projectile_delete_requested)

func _on_projectile_delete_requested(projectile):
	projectile_container.remove_child(projectile)
	projectile.queue_free()
