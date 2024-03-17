extends AttackBase
class_name AttackRay


func _getAttackDirection() -> Vector2:
	var mousePosition: Vector2 = get_global_mouse_position()
	return mousePosition - _getStartPosition()


func attack(inDirection: Vector2) -> void:
	var bullet: BulletRay = bulletScene.instantiate() as BulletRay
	
	if !is_instance_valid(bullet):
		return
	
	bullet.damage = self._getAttackDamage()
	referenceNode.add_child(bullet)
