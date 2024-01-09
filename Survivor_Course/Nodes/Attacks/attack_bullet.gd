extends AttackBase
class_name AttackBullet


func attack(inDirection: Vector2) -> void:
	var bullet: BulletStraight = bulletScene.instantiate() as BulletStraight
	
	if !is_instance_valid(bullet):
		return

	var startPosition: Vector2 = _getStartPosition()

	bullet.position = startPosition
	bullet.direction = inDirection
	add_child(bullet)


func _getAttackDirection() -> Vector2:
	var mousePosition: Vector2 = get_global_mouse_position()
	return mousePosition - _getStartPosition()
