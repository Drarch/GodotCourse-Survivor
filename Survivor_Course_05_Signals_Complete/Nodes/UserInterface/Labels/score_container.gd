extends HBoxContainer
class_name ScoreContainer

func _ready():
	Gameplay.score_changed.connect(_on_score_changed)
	

func _setScore(inScore: int) -> void:
	%Score_Label.text = "%d" % [inScore]


func _on_score_changed(inNewScore: int) -> void:
	_setScore(inNewScore)
