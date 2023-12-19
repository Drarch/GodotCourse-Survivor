extends EnemyBase
class_name SpiralEnemy

var currentAngle : float = 0.0
var radius : float = 250:
	set(inValue):
		radius = inValue
		angularSpeed = moveSpeed / radius
var radiusSpeed: float = 50

@onready var angularSpeed : float = moveSpeed / radius

func _ready():
	_setStartingParameters(targetNode)
	pass


func _setStartingParameters(inTarget: Node2D) -> void:
	if not is_instance_valid(inTarget):
		return
	
	currentAngle = fposmod(global_position.angle_to(inTarget.global_position), 2*PI)


func _move(inTarget: Node2D, inDelta: float) -> void:
	if not is_instance_valid(inTarget):
		return
	
	currentAngle = fmod(currentAngle + (angularSpeed * inDelta), 2*PI)	
	radius = maxf(_getTargetVector(inTarget).length() - radiusSpeed * inDelta, 1.0)
	
	var targetPosition = Vector2(cos(currentAngle), sin(currentAngle)) * radius
	targetPosition += inTarget.global_position
	
	moveDirection = global_position.direction_to(targetPosition)
	
	velocity = moveDirection.normalized() * moveSpeedCurrent
	move_and_slide()


#func _move(inTarget: Node2D, _inDelta: float) -> void:
	#if not is_instance_valid(inTarget):
		#return
	#
	#var targetVector = _getTargetVector(inTarget)
	#targetVector = targetVector.normalized()
	#
	#moveDirection = targetVector.rotated(deg_to_rad(60))
	#
	#velocity = moveDirection.normalized() * moveSpeedCurrent
	#move_and_slide()
