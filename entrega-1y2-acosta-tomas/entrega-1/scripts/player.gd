extends Sprite2D

var direction:int = 0
@export var speed:float = 500

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if Input.is_action_pressed("move_left"):
		direction = -1
		position.x += direction * speed * delta
	elif Input.is_action_pressed("move_right"):
		direction = 1
		position.x += direction * speed * delta
