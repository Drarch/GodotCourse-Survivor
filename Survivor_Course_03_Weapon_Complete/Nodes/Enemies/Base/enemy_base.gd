extends CharacterBody2D
class_name EnemyBase

@export var moveSpeed: float = 100.0
var moveDirection: Vector2 = Vector2.ZERO

@export var targetNode: Node2D

@onready var moveSpeedCurrent: float = moveSpeed

func _process(delta: float) -> void:
	_move(targetNode, delta)
	_lookAtTarget(targetNode)

# Movement

func _move(inTarget: Node2D, _inDelta: float) -> void:
	if not is_instance_valid(inTarget):
		return
	
	moveDirection = _getTargetVector(targetNode)
	
	velocity = moveDirection.normalized() * moveSpeedCurrent
	move_and_slide()


func _lookAtTarget(inTarget: Node2D) -> void:
	if not is_instance_valid(inTarget):
		return
	
	%View_Sprite.look_at(inTarget.global_position)

# Getters

func _getTargetVector(inTarget: Node2D) -> Vector2:
	if not is_instance_valid(inTarget):
		return Vector2.ZERO
	
	var result: Vector2 = Vector2.ZERO
	
	result = inTarget.global_position - self.global_position
	
	return result


func hit(inDamage: float) -> void:
	self.queue_free()
