extends Node2D
class_name AttackBase

@export var bulletScene: PackedScene

@export var cooldown: float = 1.0
var cooldownTimer: Timer

@export var referenceNode: Node2D


func _ready() -> void:
	_setupCooldownTimer()
	
	_startAttacking()


func _setupCooldownTimer() -> void:
	if is_instance_valid(cooldownTimer):
		cooldownTimer.queue_free()
	
	cooldownTimer = Timer.new()
	cooldownTimer.one_shot = false
	cooldownTimer.autostart = false
	cooldownTimer.wait_time = cooldown
	cooldownTimer.timeout.connect(_onCooldown_timeout)
	add_child(cooldownTimer)


func _startAttacking() -> void:
	attack(_getAttackDirection())
	cooldownTimer.start()


func attack(_inDirection: Vector2) -> void:
	pass

func _getAttackDirection() -> Vector2:
	return Vector2.ZERO


func _getStartPosition() -> Vector2:
	var result: Vector2 = Vector2.ZERO
	if is_instance_valid(referenceNode):
		result = referenceNode.global_position
	return result

func _onCooldown_timeout() -> void:
	attack(_getAttackDirection())
