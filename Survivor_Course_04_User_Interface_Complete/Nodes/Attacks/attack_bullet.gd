extends AttackBase
class_name AttackBullet


func _getAttackDirection() -> Vector2:
	var mousePosition: Vector2 = get_global_mouse_position()
	return mousePosition - _getStartPosition()


func attack(inDirection: Vector2) -> void:
	var bullet: BulletBase = bulletScene.instantiate() as BulletStraight
	
	if !is_instance_valid(bullet):
		return
		
	var startPosition: Vector2 = _getStartPosition()

	bullet.direction = inDirection.normalized()
	bullet.position = startPosition
	add_child(bullet)
