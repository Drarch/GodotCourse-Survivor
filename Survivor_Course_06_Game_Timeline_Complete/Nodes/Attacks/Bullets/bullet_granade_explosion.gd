extends BulletBase
class_name BulletGranadeExplosion

@export var explosionDuration: float = 0.5

func _ready() -> void:
	var fadeOutColor: Color = $View_Sprite.modulate * Color.TRANSPARENT
	
	var tween = get_tree().create_tween().bind_node(self).set_parallel(true)
	tween.tween_property($View_Sprite, "scale", Vector2.ONE * 2.5, explosionDuration * 0.2)
	tween.chain().tween_property($View_Sprite, "scale", Vector2.ZERO, explosionDuration * 0.8)
	tween.tween_property($View_Sprite, "modulate", fadeOutColor, explosionDuration * 0.8).set_ease(Tween.EASE_IN)
	tween.chain().tween_callback(self.queue_free)


func _hit(inBody: Node2D) -> void:
	if not inBody is EnemyBase:
		return
		
	var enemy: EnemyBase = inBody as EnemyBase
	enemy.hit(damage)


func _timerTimeout() -> void:
	%BulletArea.monitoring = false
