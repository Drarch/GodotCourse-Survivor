extends Node2D
class_name Player

@export var moveSpeed: float = 100.0

func _ready():
	pass


func _process(delta):
	pass


func _input(event: InputEvent) -> void:
	_inputKey(event as InputEventKey)
		

func _inputKey(inEventKey: InputEventKey) -> void:
	if not is_instance_valid(inEventKey):
		return
		
	if not inEventKey.is_pressed():
		return
		
	match inEventKey.keycode:
		KEY_W:
			position += Vector2.UP * moveSpeed
		KEY_S:
			position += Vector2.DOWN * moveSpeed
		KEY_A:
			position += Vector2.LEFT * moveSpeed
		KEY_D:
			position += Vector2.RIGHT * moveSpeed
