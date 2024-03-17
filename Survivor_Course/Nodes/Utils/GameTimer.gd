extends Node
class_name GameTimer

signal gameEnded(inTimeStamp: float)

const timeMax: float = 1.79769e308
@export var gameLength: float = 30 * 60

var currentTime: float = 0.0

var timeEvents: Dictionary = {} ## float -> Callable
var nextTimeEvent: float = timeMax

func _ready() -> void:
	Gameplay.gameTimer = self
	registerTimeEvent(gameLength, _gameEnd)
	

func _process(delta: float) -> void:
	currentTime += delta
	
	if nextTimeEvent < currentTime:
		_callEvent(nextTimeEvent)


func _callEvent(inTime: float) -> void:
	var eventCallable: Callable = timeEvents.get(inTime, null)
	
	if eventCallable == null:
		return
	
	eventCallable.call(inTime)
	
	timeEvents.erase(inTime)
	if timeEvents.size() > 0:
		nextTimeEvent = timeEvents.keys().min()
	else:
		nextTimeEvent = timeMax
	

func registerTimeEvent(inTime: float, inFunction: Callable) -> void:
	timeEvents[inTime] = inFunction
	
	if nextTimeEvent > inTime:
		nextTimeEvent = inTime
		
func _gameEnd(inTime: float) -> void:
	gameEnded.emit(inTime)
