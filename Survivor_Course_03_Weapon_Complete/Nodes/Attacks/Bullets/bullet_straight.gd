extends BulletBase
class_name BulletStraight

var speed: float = 650.0
var direction: Vector2 = Vector2.RIGHT

func _physics_process(delta: float) -> void:
	position += direction.normalized() * speed * delta


func _hit(inBody: Node2D) -> void:
	if not inBody is EnemyBase:
		return
		
	var enemy: EnemyBase = inBody as EnemyBase
	enemy.hit(0)
	self.queue_free()
