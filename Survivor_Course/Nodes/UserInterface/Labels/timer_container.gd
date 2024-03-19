extends HBoxContainer
class_name TimerContainer


func _ready():
	set_process(is_instance_valid(Gameplay.gameTimer))
	Gameplay.gameTimer_changed.connect(_onGameTimer_changed)
	

func _process(_delta: float) -> void:
	_updateLabels(Gameplay.gameTimer.currentTime)


## inTime [s]
func _updateLabels(inTime: float) -> void:
	var minutes: int = floori(inTime / 60.0)
	var seconds: int = int(inTime) % 60

	%Minutes_Label.text = "%02d" % [minutes]
	%Seconds_Label.text = "%02d" % [seconds]


func _onGameTimer_changed(inGameTimer: GameTimer):
	set_process(is_instance_valid(inGameTimer))
