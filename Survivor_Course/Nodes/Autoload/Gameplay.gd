extends Node

signal score_changed(inNewScore: int)

var gameTimer: GameTimer

var score: int = 0:
	get: return score
	set(inValue):
		score = inValue
		score_changed.emit(score)


func _onEnemyBase_EnemyDeath(_inEnemy: EnemyBase) -> void:
	score += 750
	
func _score():
	score += 1
