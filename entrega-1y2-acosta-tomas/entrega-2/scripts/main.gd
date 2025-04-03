extends Node2D

@export var turret_scene : PackedScene

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	var screen_size = get_viewport_rect().size
	var half_screen_y = screen_size.y / 2
	
	$Player.set_projectile_container(self)
	for i in range(3):
		var turret = turret_scene.instantiate()
		add_child(turret)
		turret.set_values($Player, self)
		var random_x = randi_range(50, screen_size.x - 50)
		var random_y = randi_range(50, half_screen_y - 50)
		
		turret.position = Vector2(random_x, random_y)
