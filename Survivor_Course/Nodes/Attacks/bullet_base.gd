extends Node2D
class_name BulletBase

@export var damage: float = 10.0

func hit(inBody: Node2D) -> void:
	pass

func _on_timer_timeout():
	self.queue_free()

func _on_bullet_area_body_entered(body: Node2D) -> void:
	hit(body)
