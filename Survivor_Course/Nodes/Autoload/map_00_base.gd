extends Node2D


func _on_enemy_base_enemy_death(inEnemy: EnemyBase) -> void:
	print("Enemy died: %s" % [inEnemy.name])
