extends CharacterBody2D
class_name EnemyBase

@export_group("Health")
@export var health: float = 60.0
@onready var currentHealth: float = health

@export_group("Move")
@export var targetNode: Node2D
@export var moveSpeed: float = 100.0
var moveDirection: Vector2 = Vector2(1.0, 0.0)

@onready var moveSpeedCurrent: float = moveSpeed

func _ready():
	%Health_ProgressBar.value = %Health_ProgressBar.max_value

func _process(delta: float) -> void:
	_move(targetNode, delta)
	
	

func _move(inTarget: Node2D, delta: float) -> void:
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
		self.queue_free()
	
	%HealthBar.visible = currentHealth != health
	
	var healthBar: ProgressBar = %Health_ProgressBar as ProgressBar
	healthBar.value = (currentHealth / health) * healthBar.max_value
