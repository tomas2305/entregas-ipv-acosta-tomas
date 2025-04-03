extends Area2D


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	var new_shape = RectangleShape2D.new()
	new_shape.extents = get_viewport_rect().size / 2  # La mitad del tamaño de la pantalla
	$CollisionShape2D.shape = new_shape  # Asignar la nueva forma

	position = Vector2.ZERO


func _on_body_exited(body: Node2D) -> void:
	print("node exit!!!")
