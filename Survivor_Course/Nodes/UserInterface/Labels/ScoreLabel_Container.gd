extends PanelContainer
class_name ScoreLabelContainer


func _ready():
	Gameplay.score_changed.connect(_onScoreChanged, CONNECT_REFERENCE_COUNTED)


func _onScoreChanged(inNewScore: int) -> void:
	%Score_Label.text = "%03d %03d" % [floori(inNewScore / 1000.0), inNewScore % 1000] 
