extends Node
class_name WaveSpawnerBase
# IEventAcitvable

@export var enemyScene: PackedScene
@export var frequency: float = 0.5
@export var maximumSpawns: int = 10

@export var spawnRelativeNode: Node2D
@export var targetNode: Node2D

@export var enemiesContainer: Node

@export var startAtReady: bool = false

var time: float = 0.0
var currentSpawns: int = 0


func _ready():
	_setEventActive(startAtReady)


func _process(delta: float) -> void:
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
	
	if !is_instance_valid(enemy):
		push_error("EnemyScene is not valid type: [EnemyBase]")
		return
	
	enemy.moveTargetNode = targetNode
	enemy.global_position = _calculateSpawnPosition()
	enemy.enemy_death.connect(_onEnemyDeath, CONNECT_ONE_SHOT)
	
	enemiesContainer.add_child(enemy)
	currentSpawns += 1


func _calculateSpawnPosition() -> Vector2:
	var spawnDistance: float = (get_viewport().size / 2.0).length()
	spawnDistance += 100.0
	
	var direction: Vector2 = Vector2.from_angle(randf() * TAU)
	
	var spawnOffsetVector = direction * spawnDistance
	
	var result = spawnRelativeNode.global_position + spawnOffsetVector
	return result


func _onEnemyDeath(_inEnemyBase: EnemyBase) -> void:
	currentSpawns -= 1


#region IEventAcitvable

func _setEventActive(inActive: bool) -> void:
	set_process(inActive)

func activateEvent(_inTime: float) -> void:
	_setEventActive(true)

func deactivateEvent(_inTime: float) -> void:
	_setEventActive(false)
	
#endregion
