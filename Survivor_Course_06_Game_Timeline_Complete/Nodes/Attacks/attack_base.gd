extends Node2D
class_name AttackBase

@export var baseDamage: float = 10.0

@export var cooldown: float = 1.0
@export var bulletScene: PackedScene

@export var referenceNode: Node2D

var cooldownTimer: Timer


func _ready():
	_checkBulletScene()
	_setupCooldownTimer()
	
	_startAttacking()


#region Setup

func _checkBulletScene() -> void:
	if !is_instance_valid(bulletScene):
		assert(false, "BulletScene not set")
		
	var bullet: BulletBase = bulletScene.instantiate() as BulletBase

	if !is_instance_valid(bullet):
		assert(false, "BulletScene is not valid type: BulletBase")
	
	bullet.queue_free()


func _setupCooldownTimer() -> void:
	if is_instance_valid(cooldownTimer):
		cooldownTimer.queue_free()
	
	cooldownTimer = Timer.new()
	cooldownTimer.one_shot = false
	cooldownTimer.autostart = false
	cooldownTimer.wait_time = cooldown
	cooldownTimer.timeout.connect(_onCooldown_timeout)
	add_child(cooldownTimer)

#endregion

func _getStartPosition() -> Vector2:
	var result: Vector2 = Vector2.ZERO
	if is_instance_valid(referenceNode):
		result = referenceNode.global_position
	return result


func _startAttacking() -> void:
	attack(_getAttackDirection())
	cooldownTimer.start()

func _getAttackDirection() -> Vector2:
	return Vector2.ZERO

func _getAttackDamage() -> float:
	return baseDamage

func attack(_inDirection: Vector2) -> void:
	pass

func _onCooldown_timeout() -> void:
	attack(_getAttackDirection())
