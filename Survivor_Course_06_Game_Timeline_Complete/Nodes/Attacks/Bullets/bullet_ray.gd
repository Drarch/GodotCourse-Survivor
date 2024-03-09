extends BulletBase
class_name BulletRay

@export var fadeoutTime: float = 1.0
var enemies: Array[EnemyBase]

func _process(delta: float) -> void:
	var mousePosition: Vector2 = get_global_mouse_position()
	_scaleRayToTarget(mousePosition)
	
	for enemy in enemies:
		enemy.hit(damage * delta)


func _scaleRayToTarget(inTargetPosition: Vector2) -> void:
	%View_Sprite.look_at(inTargetPosition)
	
	var referencePosition = inTargetPosition - self.global_position
	var rayLength = maxf(referencePosition.length(), 10.0)
	rayLength -= _getRayBaseSize().x
	%Ray_Sprite.scale.x = (rayLength * %Ray_Sprite.scale.x) / _getRayBeamSize().x


func _fadeOutRay() -> void:
	var fadeOutColor: Color = %View_Sprite.modulate * Color.TRANSPARENT
	var tween = get_tree().create_tween().bind_node(self).set_parallel(true)
	tween.tween_property(self, "damage", 0, fadeoutTime)
	tween.tween_property(%View_Sprite, "modulate", fadeOutColor, fadeoutTime).set_ease(Tween.EASE_IN)
	tween.chain().tween_callback(self.queue_free)


func _timerTimeout() -> void:
	_fadeOutRay()


func _getRayBaseSize() -> Vector2:
	var rayBase: Sprite2D = %View_Sprite as Sprite2D
	return rayBase.get_rect().size * rayBase.global_scale


func _getRayBeamSize() -> Vector2:
	var rayBase: Sprite2D = %Ray_Sprite as Sprite2D
	return rayBase.get_rect().size * rayBase.global_scale


func _on_ray_area_body_entered(inBody):
	if not inBody is EnemyBase:
		return
		
	enemies.append(inBody)


func _on_ray_area_body_exited(inBody):
	if not inBody is EnemyBase:
		return

	enemies.erase(inBody)
