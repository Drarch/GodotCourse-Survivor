extends CharacterBody2D
class_name EnemyBase

signal enemy_death(inEnemy: EnemyBase)

@export_group("Health")
@export var health: float = 60.0
@onready var currentHealth: float = health

@export_group("Attack")
@export var attackDamage: float = 1.0
var attackTarget: Node2D

@export_group("Move")
@export var moveSpeed: float = 100.0
@onready var moveSpeedCurrent: float = moveSpeed
var moveDirection: Vector2 = Vector2.ZERO

@export var moveTargetNode: Node2D

@export_group("Advanced")
@export var damageIndicatorScene: PackedScene = preload("res://Nodes/UserInterface/DamageIndicator/damage_indicator.tscn")

func _ready():
	_checkDamageIndicator()
	enemy_death.connect(Gameplay._on_enemy_death)


func _process(delta: float) -> void:
	_move(moveTargetNode, delta)
	_lookAtTarget(moveTargetNode)
	attack(attackTarget, attackDamage * delta)

#region Setup

func _checkDamageIndicator() -> bool:
	var instance: DamageIndicator = _instntiateDamagaIndicator()
	
	if is_instance_valid(instance):
		instance.queue_free()
		return true
	
	return false

#endregion

#region Movement

func _move(inTarget: Node2D, _inDelta: float) -> void:
	if not is_instance_valid(inTarget):
		return
	
	moveDirection = _getTargetVector(moveTargetNode)
	
	velocity = moveDirection.normalized() * moveSpeedCurrent
	move_and_slide()


func _lookAtTarget(inTarget: Node2D) -> void:
	if not is_instance_valid(inTarget):
		return
	
	%View_Sprite.look_at(inTarget.global_position)

#endregion

#region Hit

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
		_death()
	
	%HealthBar.visible = currentHealth != health
	
	var healthBar: ProgressBar = %Health_ProgressBar as ProgressBar
	healthBar.value = (currentHealth / health) * healthBar.max_value
	
	_spawnDamagaIndicator(inDamage)


func _death() -> void:
	enemy_death.emit(self)
	self.queue_free()

#endregion

#region Attack

func attack(inTarget: Node2D, inDamage: float) -> void:
	if !is_instance_valid(inTarget) || not "hit" in inTarget:
		return
		
	inTarget.hit(inDamage)


func _on_attack_area_2d_body_entered(inBody: Node2D) -> void:
	if is_instance_valid(attackTarget):
		return
		
	attackTarget = inBody


func _on_attack_area_2d_body_exited(inBody: Node2D) -> void:
	if attackTarget == inBody:
		attackTarget = null


#endregion

# Getters

func _getTargetVector(inTarget: Node2D) -> Vector2:
	if not is_instance_valid(inTarget):
		return Vector2.ZERO
	
	var result: Vector2 = Vector2.ZERO
	
	result = inTarget.global_position - self.global_position
	
	return result







