extends Area2D

var exited_amount = 0

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	var screen_size = get_viewport_rect().size
	
	global_position = screen_size / 2
	var shape = RectangleShape2D.new()
	shape.extents = (screen_size * 1.2) / 2
	$CollisionShape2D.shape = shape
	
	monitoring = true
	add_to_group("killzone")
	
	print("KillZone Position:", global_position)



func _on_area_exited(area: Area2D) -> void:
	if area.is_in_group("projectile"):
		exited_amount += 1
		print("exited amount:", exited_amount)
		area.queue_free()
