extends CharacterBody2D
class_name EnemyBase

@export var moveSpeed: float = 100.0
var moveDirection: Vector2 = Vector2.ZERO

@export var targetNode: Node2D

@onready var moveSpeedCurrent: float = moveSpeed

func _process(delta: float) -> void:
	moveDirection = _getTargetVector(targetNode)
	_move(moveDirection, delta)

# Movement

func _move(inDirection: Vector2, _inDelta: float) -> void:
	velocity = inDirection.normalized() * moveSpeedCurrent
	move_and_slide()

# Getters

func _getTargetVector(inTarget: Node2D) -> Vector2:
	if not is_instance_valid(inTarget):
		return Vector2.ZERO
	
	var result: Vector2 = Vector2.ZERO
	
	result = inTarget.global_position - self.global_position
	
	return result
