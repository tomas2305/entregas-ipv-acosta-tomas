extends Sprite2D

@export var projectile_scene : PackedScene
@onready var fire_position = $FirePosition

var player : Sprite2D
var projectile_container : Node2D

func set_values(player_target : Sprite2D, container : Node2D ):
	self.player = player_target
	self.projectile_container = container
	
	$Timer.start()


func _on_timer_timeout() -> void:
	fire()
	
	
func fire():
	var projectile: Projectile = projectile_scene.instantiate()
	var direction = (player.global_position - fire_position.global_position).normalized()
	
	projectile_container.add_child(projectile)
	projectile.set_starting_values(fire_position.global_position, direction)
	projectile.delete_requested.connect(_on_projectile_delete_requested)
	
	 
func _on_projectile_delete_requested(projectile):
	projectile_container.remove_child(projectile)
	projectile.queue_free()
