extends AbstractState

onready var walk_sound = $"../../WalkSound"

var step_timer := 0.0
const STEP_INTERVAL := 0.3

# Al entrar se activa primero la animación "walk"
func enter() -> void:
	character._play_animation("walk")


func handle_input(event:InputEvent) -> void:
	if event.is_action_pressed("jump") && character.is_on_floor():
		emit_signal("finished", "jump")
	elif event.is_action_pressed("dash"):
		emit_signal("finished", "dash")


# En esta función vamos a manejar las acciones apropiadas para este estado
func update(delta: float) -> void:
	character._handle_weapon_actions(delta)
	character._handle_move_input()
	character._apply_movement()

	if character.move_direction == 0:
		emit_signal("finished", "idle")
	else:
		if character.is_on_floor():
			character._play_animation("walk")
			
			step_timer -= delta
			if step_timer <= 0.0:
				play_random_step()
				step_timer = STEP_INTERVAL
		else:
			if character.velocity.y > 0:
				character._play_animation("fall")
			else:
				character._play_animation("jump")


# En este callback manejamos, por el momento, solo los impactos
func handle_event(event: String, value = null) -> void:
	match event:
		"hit", "healed":
			character.sum_hp(value)
		"hp_changed":
			if value[0] == 0:
				emit_signal("finished", "dead")
				
				
				
var step_sounds = [
	preload("res://assets/sound/sfx/movement/16_human_walk_stone_1.wav"),
		preload("res://assets/sound/sfx/movement/16_human_walk_stone_2.wav"),
			preload("res://assets/sound/sfx/movement/16_human_walk_stone_3.wav"),
	]

func play_random_step():
	walk_sound.stream = step_sounds[randi() % step_sounds.size()]
	walk_sound.play()

