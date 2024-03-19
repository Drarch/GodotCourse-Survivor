extends Node

signal score_changed(inNewScore: int)
signal gameTimer_changed(inGameTimer: GameTimer)

var gameTimer: GameTimer:
	get: return gameTimer
	set(inValue):
		gameTimer = inValue
		gameTimer_changed.emit(gameTimer)

var score: int = 0:
	get: return score
	set(inValue):
		score = inValue
		score_changed.emit(score)


func _onEnemyBase_EnemyDeath(_inEnemy: EnemyBase) -> void:
	score += 750
	
func _score():
	score += 1
