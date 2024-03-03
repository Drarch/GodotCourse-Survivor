extends CharacterBody2D
class_name EnemyBase

signal enemy_death(inEnemy: EnemyBase)

@export_group("Health")
@export var health: float = 60.0
@onready var currentHealth: float = health

@export_group("Attack")
@export var attackDamage: float = 1.0
@export var attackCooldown: float = 1.0
var attackTarget: Node2D

@export_group("Move")
@export var moveSpeed: float = 100.0
@onready var moveSpeedCurrent: float = moveSpeed
var moveDirection: Vector2 = Vector2.ZERO

@export var moveTargetNode: Node2D

@export_group("Advanced")
@export var damageIndicatorScene: PackedScene = preload("res://Nodes/UI/DamageIndicator/damage_indicator.tscn")

func _ready():
	_checkDamageIndicator()
	_setupTimer()
	enemy_death.connect(Gameplay._on_enemy_death)


func _process(delta: float) -> void:
	_move(moveTargetNode, delta)
	_lookAtTarget(moveTargetNode)

#region Setup

func _checkDamageIndicator() -> bool:
	var instance: DamageIndicator = _instntiateDamagaIndicator()
	
	if is_instance_valid(instance):
		instance.queue_free()
		return true
	
	return false

func _setupTimer() -> void:
	var timer: Timer = %Attack_Timer as Timer
	
	if !is_instance_valid(timer):
		push_error("Timer not exist.")
		return
	
	timer.stop()
	timer.wait_time = attackCooldown
	timer.autostart = false
	timer.one_shot = false

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

func attack(inTarget: Node2D) -> void:
	if !is_instance_valid(inTarget) && "hit" in inTarget:
		return
		
	inTarget.hit(attackDamage)

func _on_attack_area_2d_body_entered(inBody: Node2D) -> void:
	if is_instance_valid(attackTarget):
		return
		
	attackTarget = inBody
	%Attack_Timer.start()


func _on_attack_area_2d_body_exited(inBody: Node2D) -> void:
	if attackTarget == inBody:
		attackTarget = null
		%Attack_Timer.stop()
		

func _onAttackTimer_Timeout() -> void:
	attack(attackTarget)

#endregion

# Getters

func _getTargetVector(inTarget: Node2D) -> Vector2:
	if not is_instance_valid(inTarget):
		return Vector2.ZERO
	
	var result: Vector2 = Vector2.ZERO
	
	result = inTarget.global_position - self.global_position
	
	return result







