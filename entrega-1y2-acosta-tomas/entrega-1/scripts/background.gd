extends TextureRect


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	size = get_viewport_rect().size
	position = Vector2.ZERO
