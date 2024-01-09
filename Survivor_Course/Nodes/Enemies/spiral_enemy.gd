extends EnemyBase
class_name SpiralEnemy

func _move(inTarget: Node2D, _inDelta: float) -> void:
	if not is_instance_valid(inTarget):
		return
	
	%View_Sprite2D.look_at(inTarget.global_position)
	
	var targetVector = _getTargetVector(inTarget)
	targetVector = targetVector.normalized()
	
	moveDirection = targetVector.rotated(deg_to_rad(60))
	
	velocity = moveDirection.normalized() * moveSpeedCurrent
	move_and_slide()
