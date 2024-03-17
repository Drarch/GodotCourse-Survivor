extends CharacterBody2D
class_name EnemyBase

signal enemy_death(inEnemy: EnemyBase)

@export_group("Health")
@export var health: float = 60.0
@onready var currentHealth: float = health

@export_group("Move")
@export var targetNode: Node2D
@export var moveSpeed: float = 100.0
var moveDirection: Vector2 = Vector2(1.0, 0.0)

@export_group("Attack")
@export var attackDamage: float = 5.0
var attackNode: Node2D = null

@onready var moveSpeedCurrent: float = moveSpeed

@export_group("Advanced")
@export var damageIndicatorScene: PackedScene = preload("res://Nodes/Controls/damage_indicator.tscn")


func _ready():
	%Health_ProgressBar.value = %Health_ProgressBar.max_value
	
	self.enemy_death.connect(Gameplay._onEnemyBase_EnemyDeath)

func _process(delta: float) -> void:
	_move(targetNode, delta)
	attack(attackNode, attackDamage * delta)
	
	

func _move(inTarget: Node2D, _delta: float) -> void:
	if not is_instance_valid(inTarget):
		return
	
	%View_Sprite2D.look_at(inTarget.global_position)
	moveDirection = _getTargetVector(inTarget)
	
	velocity = moveDirection.normalized() * moveSpeedCurrent
	move_and_slide()

# Getters

func _getTargetVector(inTarget: Node2D) -> Vector2:
	if not is_instance_valid(inTarget):
		return Vector2.ZERO
	
	var result: Vector2 = Vector2.ZERO
	
	result = inTarget.global_position - self.global_position
	
	return result


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


func _spawnDamagaIndicator(inDamage: float) -> void:
	if !is_instance_valid(damageIndicatorScene):
		push_error("DamageIndicatorScene not set")
		return
	
	var instance: DamageIndicator = damageIndicatorScene.instantiate() as DamageIndicator
	
	if !is_instance_valid(instance):
		push_error("DamageIndicatorScene is not valid type: DamageIndicator")
		return
	
	instance.damageValue = inDamage
	%DamageIndicator_Container.add_child(instance)


#region Attack

func attack(inTarget: Node2D, inDamage: float) -> void:
	if !is_instance_valid(inTarget) || not "hit" in inTarget:
		return
		
	inTarget.hit(inDamage)


func _on_attack_area_2d_body_entered(body):
	if not body is Player:
		pass
	
	attackNode = body


func _on_attack_area_2d_body_exited(body):
	if is_instance_valid(attackNode) && attackNode == body:
		attackNode = null
	
#endregion
