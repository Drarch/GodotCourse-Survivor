extends BulletBase
class_name BulletGranade

@export var speed: float = 350.0
var direction: Vector2 = Vector2.RIGHT
var target: Vector2 = Vector2.ZERO

@export var bulletExplosionScene: PackedScene = preload("res://Nodes/Attacks/Bullets/bullet_granade_explosion.tscn")
@export var exlosionContainerNode: Node2D = self

func _physics_process(delta: float) -> void:
	position += direction.normalized() * speed * delta
	if global_position.distance_squared_to(target) <= 25.0:
		_explode()


func _explode():
	var explosionNode: BulletGranadeExplosion = bulletExplosionScene.instantiate() as BulletGranadeExplosion
	
	if !is_instance_valid(explosionNode):
		return
	
	explosionNode.global_position = self.global_position
	exlosionContainerNode.add_child(explosionNode)
	self.queue_free()
