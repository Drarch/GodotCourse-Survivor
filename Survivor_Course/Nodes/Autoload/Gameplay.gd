extends Node

signal score_changed(inNewScore: int)

var score: int = 0

func _onEnemyBase_EnemyDeath(inEnemy: EnemyBase) -> void:
	score += 10
	score_changed.emit(score)
