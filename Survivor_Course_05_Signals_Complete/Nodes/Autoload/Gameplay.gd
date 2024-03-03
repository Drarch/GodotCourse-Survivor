extends Node

signal score_changed(inNewScore: int)

var score: int = 0:
	get: return score
	set(inValue):
		score = inValue
		score_changed.emit(score)



func _on_enemy_death(inEnemy: EnemyBase) -> void:
	score += 10

