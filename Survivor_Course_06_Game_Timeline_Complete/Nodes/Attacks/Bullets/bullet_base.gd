extends Node2D
class_name BulletBase

var damage: float = 10.0

func _hit(_inBody: Node2D) -> void:
	pass

func _timerTimeout() -> void:
	self.queue_free()

func _on_bullet_area_body_entered(inBody: Node2D):
	_hit(inBody)

func _on_timer_timeout():
	_timerTimeout()
	
