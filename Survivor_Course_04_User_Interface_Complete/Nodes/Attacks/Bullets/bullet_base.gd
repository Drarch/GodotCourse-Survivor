extends Node2D
class_name BulletBase

func _hit(_inBody: Node2D) -> void:
	pass

func _on_bullet_area_body_entered(inBody: Node2D):
	_hit(inBody)

func _on_timer_timeout():
	self.queue_free()
