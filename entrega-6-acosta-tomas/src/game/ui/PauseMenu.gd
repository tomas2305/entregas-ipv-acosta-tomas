extends Control

## Menú de pausa genérico, abierto utilizando la acción "pause_menu"
## (por default la tecla Esc).

onready var options_menu = $OptionsMenu

signal return_selected()
 
func _ready() -> void:
	hide()


func _unhandled_input(event: InputEvent) -> void:
	if event.is_action_released("pause_menu") && !options_menu.visible:
		visible = !visible
		get_tree().paused = visible


func _on_ResumeButton_pressed() -> void:
	hide()
	get_tree().paused = false


func _on_MenuButton_pressed():
	emit_signal("return_selected")
