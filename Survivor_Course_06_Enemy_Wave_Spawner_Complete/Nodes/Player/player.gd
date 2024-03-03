extends CharacterBody2D
class_name Player

@export_group("Player")
@export var maxHealth: float = 100.0
@onready var currentHealth: float = maxHealth
@export var moveSpeed: float = 100.0
@export var moveSprintFactor: float = 2.0

@export_group("World")
@export var worldEntities: Node2D

@onready var moveSpeedCurrent: float = moveSpeed
var moveDirection: Vector2 = Vector2.ZERO

func _ready() -> void:
	updateHealthBar()


func _process(delta: float) -> void:
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


func _inputMouse(inEvent: InputEventMouseMotion) -> void:
	if not is_instance_valid(inEvent):
		return
	
	var worldPosition: Vector2 = get_canvas_transform().affine_inverse() * inEvent.global_position
	%View_Sprite.look_at(worldPosition)
	#prints(get_global_mouse_position(), worldPosition)
	

# Movement

func _move(inDirection: Vector2, inDelta: float) -> void:
	position += inDirection.normalized() * moveSpeedCurrent * inDelta


#region Health

func hit(inDamage: float) -> void:
	currentHealth -= inDamage
	if currentHealth <= 0.0:
		#Player dead
		pass
	
	updateHealthBar()

func updateHealthBar() -> void:
	var healthBar: ProgressBar = %Health_ProgressBar as ProgressBar
	healthBar.value = (currentHealth / maxHealth) * healthBar.max_value

#endregion

# Getters

func _getMoveDirectionSign(inIsPressed: bool) -> int:
	return 1 if inIsPressed else -1

