extends AttackBase
class_name AttackGranade

@export var exlosionContainerNode: Node2D

func _getAttackDirection() -> Vector2:
	var mousePosition: Vector2 = get_global_mouse_position()
	return mousePosition - _getStartPosition()


func attack(inDirection: Vector2) -> void:
	var bullet: BulletGranade = bulletScene.instantiate() as BulletGranade
	
	if !is_instance_valid(bullet):
		return
		
	var startPosition: Vector2 = _getStartPosition()

	bullet.damage = self._getAttackDamage()
	bullet.direction = inDirection.normalized()
	bullet.position = startPosition
	bullet.target = startPosition + inDirection
	bullet.exlosionContainerNode = exlosionContainerNode
	add_child(bullet)
