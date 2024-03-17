extends Node
class_name WaveSpawner

@export var enemyScene: PackedScene
@export var frequency: float = 0.5
@export var maximumSpawns: int = 10

@export var spawnRelativeNode: Node2D
@export var targetNode: Node2D

@export var enemiesContainer: Node

var time: float = 0.0

func _process(delta: float) -> void:
	time += delta
	if time > frequency:
		time -= frequency
		spawnEnemy()


func spawnEnemy() -> void:
	if not is_instance_valid(enemyScene):
		return
		
	var enemy: EnemyBase = enemyScene.instantiate() as EnemyBase
	enemy.moveTargetNode = targetNode
	enemy.global_position = _calculateSpawnPosition()
	
	enemiesContainer.add_child(enemy)


func _calculateSpawnPosition() -> Vector2:
	var spawnOffsetVector = Vector2.LEFT * 500.0
	
	var result = spawnRelativeNode.global_position + spawnOffsetVector
	return result
