extends CharacterBody2D
class_name Player

@export var moveSpeed: float = 100.0
@export var moveSprintFactor: float = 2.0
var moveDirection: Vector2 = Vector2.ZERO

@onready var moveSpeedCurrent: float = moveSpeed

func _ready():
	pass


func _process(delta: float): # delta => 60fps 1000ms / 60 = 16,6ms
	_move(moveDirection, delta)


func _input(event: InputEvent) -> void:
	_inputAction(event)
	_inputMouse(event as InputEventMouseMotion)
#	_inputKey(event as InputEventKey)
	

func _inputAction(inEvent: InputEvent) -> void:
	if not is_instance_valid(inEvent):
		return
	
	if not inEvent.is_action_type():
		return
	
	if inEvent.is_echo():
		return
		
	var directionFactor: int = _getMoveDirectionSign(inEvent.is_pressed())
	
	# boll 0
	# int 0000 0000 1100 1100
	var actionMask: int = 0
	actionMask += int(inEvent.is_action(&"MoveUp")) << 0 # 0/1
	actionMask += int(inEvent.is_action(&"MoveDown")) << 1 #0/2 - bool (01 << 1) = 10
	actionMask += int(inEvent.is_action(&"MoveLeft")) << 2 #0/4
	actionMask += int(inEvent.is_action(&"MoveRight")) << 3 #0/8
	actionMask += int(inEvent.is_action(&"MoveSprint")) << 4 #0/16

	match actionMask:
		1 << 0:
			moveDirection += Vector2.UP * directionFactor
		1 << 1:
			moveDirection += Vector2.DOWN * directionFactor
		1 << 2:
			moveDirection += Vector2.LEFT * directionFactor
		1 << 3:
			moveDirection += Vector2.RIGHT * directionFactor
		1 << 4:
			var sprintFactor = moveSprintFactor if inEvent.is_pressed() else 1.0
			moveSpeedCurrent = moveSpeed * sprintFactor
			


func _inputKey(inEventKey: InputEventKey) -> void:
	if not is_instance_valid(inEventKey):
		return
		
	if inEventKey.is_echo():
		return
	
	var directionFactor: int = _getMoveDirectionSign(inEventKey.is_pressed())
	
	match inEventKey.keycode:
		KEY_W:
			moveDirection += Vector2.UP * directionFactor
		KEY_S:
			moveDirection += Vector2.DOWN * directionFactor
		KEY_A:
			moveDirection += Vector2.LEFT * directionFactor
		KEY_D:
			moveDirection += Vector2.RIGHT * directionFactor


func _inputMouse(inEvent: InputEventMouseMotion) -> void:
	if not is_instance_valid(inEvent):
		return
	
	var worldPosition: Vector2 = get_canvas_transform().affine_inverse() * inEvent.global_position
	%View_Sprite.look_at(worldPosition)
	#prints(get_global_mouse_position(), worldPosition)


func _move(inDirection: Vector2, delta: float) -> void:
	position += inDirection * moveSpeedCurrent * delta


func _getMoveDirectionSign(inIsPressed: bool) -> int:
	return 1 if inIsPressed else -1  # [jeśli prawda] if [warunek] else [jeśli fałsz]
