extends Node
class_name WaveSpawnerBase

@export var enemyScene: PackedScene
@export var frequency: float = 0.5
@export var maximumSpawns: int = 5

@export var spawnRelativeNode: Node2D
@export var targetNode: Node2D

@export var enemiesContainer: Node

var time: float = 0
var currentSpawns: int = 0

func _process(delta) -> void:
	time += delta
	if time > frequency:
		time -= frequency
		spawnEnemy()


func spawnEnemy() -> void:
	if currentSpawns >= maximumSpawns:
		return
	
	if not is_instance_valid(enemyScene):
		return
	
	var enemy: EnemyBase = enemyScene.instantiate() as EnemyBase
	
	if not is_instance_valid(enemy):
		push_error("EnemyScene is not valid type: [EnemyBase]")
		return
	
	enemy.targetNode = targetNode
	enemy.global_position = _calculateSpawnPosition()
	enemy.enemy_death.connect(_onEnemyDeath, CONNECT_ONE_SHOT)
	
	enemiesContainer.add_child(enemy)
	currentSpawns += 1
	

func _calculateSpawnPosition() -> Vector2:
	var spawnDistance: float = (get_viewport().size / 2.0).length()
	spawnDistance += 100
	
	var spawnDirection: Vector2 = Vector2.from_angle(randf() * TAU)
	
	var result = spawnRelativeNode.global_position if is_instance_valid(spawnRelativeNode) else Vector2.ZERO
	result += spawnDirection * spawnDistance
	
	return result


func _onEnemyDeath(_inEnemy: EnemyBase) -> void:
	currentSpawns -= 1
