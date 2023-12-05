#---------- class_name

extends Node2D
class_name Player


#---------- func _input(event)

func _input(event: InputEvent) -> void:
	if event is InputEventKey:
		print(event.as_text_keycode())
		
#---------- func _inputKey(inEventKey: InputEventKey) -> void

func _input(event: InputEvent) -> void:
	_inputKey(event as InputEventKey)


func _inputKey(inEventKey: InputEventKey) -> void:
	if !is_instance_valid(inEventKey):
		return
		
	print(inEventKey.as_text_keycode())
	
	
#---------- match inEventKey.keycode

func _inputKey(inEventKey: InputEventKey) -> void:
	if !is_instance_valid(inEventKey):
		return
		
	match inEventKey.keycode:
		KEY_W: print("Up")
		KEY_A: print("Down")
		KEY_S: print("Left")
		KEY_D: print("Right")


#---------- inEventKey.is_pressed()

func _inputKey(inEventKey: InputEventKey) -> void:
	if not is_instance_valid(inEventKey):
		return
	
	if not inEventKey.is_pressed():
		return
	
	match inEventKey.keycode:
		KEY_W: print("Up: %s" % [inEventKey])
		KEY_A: print("Down: %s" % [inEventKey])
		KEY_S: print("Left: %s" % [inEventKey])
		KEY_D: print("Right: %s" % [inEventKey])
	

#---------- position += Vector2.UP
		
func _inputKey(inEventKey: InputEventKey) -> void:
	if not is_instance_valid(inEventKey):
		return
	
	if not inEventKey.is_pressed():
		return
	
	match inEventKey.keycode:
		KEY_W:
			position += Vector2.UP
		KEY_A:
			position += Vector2.LEFT
		KEY_S:
			position += Vector2.DOWN
		KEY_D:
			position += Vector2.RIGHT
		

#---------- @export var moveSpeed: float

@export var moveSpeed: float = 100.0	
		
func _inputKey(inEventKey: InputEventKey) -> void:
	if not is_instance_valid(inEventKey):
		return
	
	if not inEventKey.is_pressed():
		return
	
	match inEventKey.keycode:
		KEY_W: 
			position += Vector2.UP * moveSpeed
		KEY_A:
			position += Vector2.LEFT * moveSpeed
		KEY_S:
			position += Vector2.DOWN * moveSpeed
		KEY_D:
			position += Vector2.RIGHT * moveSpeed


#---------- func _move(inDirection: Vector2) -> void -------- Tutaj skończyłem

var moveDirection: Vector2 = Vector.ZERO

func _input(event: InputEvent) -> void:
	_inputKey(event as InputEventKey)
	_move(moveDirection)


func _inputKey(inEventKey: InputEventKey) -> void:
	if not is_instance_valid(inEventKey):
		return
	
	if inEventKey.is_echo():
		return
	
	var directionFactor: int = _getMoveDirectionSign(inEventKey)
	
	match inEventKey.keycode:
		KEY_W: 
			moveDirection += Vector2.UP * directionFactor
		KEY_A:
			moveDirection += Vector2.LEFT * directionFactor
		KEY_S:
			moveDirection += Vector2.DOWN * directionFactor
		KEY_D:
			moveDirection += Vector2.RIGHT * directionFactor

# Movement

func _move(inDirection: Vector2) -> void:
	position += inDirection * moveSpeed


# Getters

func _getMoveDirectionSign(inEventKey: InputEventKey) -> int:
	return 1 if inEventKey.is_pressed() else -1


#-------- func _process(delta: float) -> void

func _process(delta: float) -> void:
	_move(moveDirection, delta)

(...)

func _input(event: InputEvent) -> void:
	_inputKey(event as InputEventKey)
	

#-------- func _inputAction(inEvent: InputEvent) -> void

func _input(event: InputEvent) -> void:
	_inputAction(event)
#	_inputKey(event as InputEventKey)


func _inputAction(inEvent: InputEvent) -> void:
	if not is_instance_valid(inEvent):
		return
		
	if not inEvent.is_action_type():
		return
	
	if inEvent.is_echo():
		return
		
	var directionFactor: int = _getMoveDirectionSign(inEvent.is_pressed())
	
	prints(inEvent, directionFactor)
	

#-------- inEvent.is_action(&"MoveUp")

func _inputAction(inEvent: InputEvent) -> void:
	if not is_instance_valid(inEvent):
		return
		
	if not inEvent.is_action_type():
		return
	
	if inEvent.is_echo():
		return
		
	var directionFactor: int = _getMoveDirectionSign(inEvent.is_pressed())
	
	if inEvent.is_action(&"MoveUp"):
		moveDirection += Vector2.UP * directionFactor
	elif inEvent.is_action(&"MoveDown"):
		moveDirection += Vector2.DOWN * directionFactor
	elif inEvent.is_action(&"MoveLeft"):
		moveDirection += Vector2.LEFT * directionFactor
	elif inEvent.is_action(&"MoveRight"):
		moveDirection += Vector2.RIGHT * directionFactor
		

#------- var actionMask: int = 0

func _inputAction(inEvent: InputEvent) -> void:
	if not is_instance_valid(inEvent):
		return
		
	if not inEvent.is_action_type():
		return
	
	if inEvent.is_echo():
		return
		
	var directionFactor: int = _getMoveDirectionSign(inEvent.is_pressed())
	
	var actionMask: int = 0
	actionMask += int(inEvent.is_action(&"MoveUp")) # 0/1
	actionMask += int(inEvent.is_action(&"MoveDown")) << 1 #0/2
	actionMask += int(inEvent.is_action(&"MoveLeft")) << 2 #0/4
	actionMask += int(inEvent.is_action(&"MoveRight")) << 3 #0/8
	
	match actionMask:
		1 << 0:
			moveDirection += Vector2.UP * directionFactor
		1 << 1:
			moveDirection += Vector2.DOWN * directionFactor
		1 << 2:
			moveDirection += Vector2.LEFT * directionFactor
		1 << 3:
			moveDirection += Vector2.RIGHT * directionFactor
		
		
#------ inEvent.is_action(&"MoveSprint")

@export var moveSprintFactor: float = 2.0

@onready var moveSpeedCurrent: float = moveSpeed

(...)

func _inputAction(inEvent: InputEvent) -> void:
	if not is_instance_valid(inEvent):
		return
		
	if not inEvent.is_action_type():
		return
	
	if inEvent.is_echo():
		return
		
	var directionFactor: int = _getMoveDirectionSign(inEvent.is_pressed())
	
	var actionMask: int = 0
	actionMask += int(inEvent.is_action(&"MoveUp")) # 0/1
	actionMask += int(inEvent.is_action(&"MoveDown")) << 1 #0/2
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
			
(...)

func _move(inDirection: Vector2, inDelta: float) -> void:
	position += inDirection.normalized() * moveSpeedCurrent * inDelta
	
	
	
	
#---------

get_action_strength ( StringName action, bool exact_match=false )