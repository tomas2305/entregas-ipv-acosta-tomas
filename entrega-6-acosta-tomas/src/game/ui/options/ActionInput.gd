tool
extends Node

onready var input = $HBoxContainer/Panel/Input
onready var action = $HBoxContainer/Action

export (String) var action_input: String setget _set_action_input
export (String) var action_name: String setget _set_action_name

func _ready() -> void:
	input.text = action_input
	action.text = action_name

func _set_action_input(inp: String) -> void:
	action_input = inp
	if Engine.editor_hint && has_node(input):
		input.text = inp
		
func _set_action_name(nm: String) -> void:
	action_name = nm
	if Engine.editor_hint && has_node(action):
		action.text = nm
	
