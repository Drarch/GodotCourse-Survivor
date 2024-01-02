extends Node2D
class_name BulletBase

var speed: float = 650.0
var direction: Vector2 = Vector2.RIGHT

func _physics_process(delta: float) -> void:
	position += direction.normalized() * speed * delta

func _on_timer_timeout():
	self.queue_free()
