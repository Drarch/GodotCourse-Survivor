extends BulletBase
class_name BulletStraight


var speed: float = 650.0
var direction: Vector2 = Vector2.RIGHT

func _physics_process(delta: float) -> void:
	position += direction.normalized() * speed * delta

func hit(inBody: Node2D) -> void:
	var enemy: EnemyBase = inBody as EnemyBase
	if !is_instance_valid(enemy):
		return
	
	enemy.hit(damage)
	self.queue_free()
