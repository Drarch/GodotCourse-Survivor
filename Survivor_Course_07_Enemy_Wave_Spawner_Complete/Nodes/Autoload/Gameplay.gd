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

func _scoreDeath(_inEnemy: EnemyBase) -> void:
	score += 10


func _on_enemy_death(inEnemy: EnemyBase) -> void:
	_scoreDeath(inEnemy)

