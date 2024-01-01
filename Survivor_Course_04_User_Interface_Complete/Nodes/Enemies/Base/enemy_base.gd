extends CharacterBody2D
class_name EnemyBase

@export var health: float = 60.0
@onready var currentHealth: float = health

@export var moveSpeed: float = 100.0
var moveDirection: Vector2 = Vector2.ZERO

@export var targetNode: Node2D

@onready var moveSpeedCurrent: float = moveSpeed

@export var damageIndicatorScene: PackedScene = preload("res://Nodes/UI/DamageIndicator/damage_indicator.tscn")

func _ready():
	_checkDamageIndicator()


func _process(delta: float) -> void:
	_move(targetNode, delta)
	_lookAtTarget(targetNode)

# Setup

func _checkDamageIndicator() -> bool:
	var instance: DamageIndicator = _instntiateDamagaIndicator()
	
	if is_instance_valid(instance):
		instance.queue_free()
		return true
	
	return false





# Movement

func _move(inTarget: Node2D, _inDelta: float) -> void:
	if not is_instance_valid(inTarget):
		return
	
	moveDirection = _getTargetVector(targetNode)
	
	velocity = moveDirection.normalized() * moveSpeedCurrent
	move_and_slide()


func _lookAtTarget(inTarget: Node2D) -> void:
	if not is_instance_valid(inTarget):
		return
	
	%View_Sprite.look_at(inTarget.global_position)

# Hit

func _instntiateDamagaIndicator() -> DamageIndicator:
	if !is_instance_valid(damageIndicatorScene):
		push_error("DamageIndicatorScene not set")
		return null
		
	var instance: DamageIndicator = damageIndicatorScene.instantiate() as DamageIndicator

	if !is_instance_valid(instance):
		push_error("DamageIndicatorScene is not valid type: DamageIndicator")
		return null
	
	return instance

func _spawnDamagaIndicator(inDamage: float) -> void:
	var damageIndicator: DamageIndicator = _instntiateDamagaIndicator()
	
	if !is_instance_valid(damageIndicator):
		return
		
	damageIndicator.damageValue = inDamage
	%DamageIndicatorContainer.add_child(damageIndicator)


func hit(inDamage: float) -> void:
	currentHealth -= inDamage
	if currentHealth <= 0.0:
		self.queue_free()
	
	%HealthBar.visible = currentHealth != health
	
	var healthBar: ProgressBar = %Health_ProgressBar as ProgressBar
	healthBar.value = (currentHealth / health) * healthBar.max_value
	
	_spawnDamagaIndicator(inDamage)


# Getters

func _getTargetVector(inTarget: Node2D) -> Vector2:
	if not is_instance_valid(inTarget):
		return Vector2.ZERO
	
	var result: Vector2 = Vector2.ZERO
	
	result = inTarget.global_position - self.global_position
	
	return result

