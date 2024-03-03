extends Node
class_name GameTimer

signal gameEnded(inTimeStamp: float)

const timeMax: float = 1.79769e308
@export var gameLength: float = 30 * 60

var currentTime = 0.0

## [Timestamp, [Callable]]
var timeEvents: Dictionary = {}
var nextTimeEvent: float = timeMax


func _ready() -> void:
	registerTimeEvent(gameLength, _gameEnd)


func _process(delta: float) -> void:
	currentTime += delta
	
	if nextTimeEvent <= currentTime:
		_callEvent(nextTimeEvent)


func _gameEnd(inTime: float):
	set_process(false)
	gameEnded.emit(inTime)


func _callEvent(inTime: float) -> void:
	for event in timeEvents[inTime]:
		var eventCallable: Callable = event as Callable
		if eventCallable != null && eventCallable.is_valid():
			eventCallable.call(inTime)
	
	timeEvents.erase(inTime)
	
	if timeEvents.size() > 0:
		nextTimeEvent = timeEvents.keys().min()
	else:
		nextTimeEvent = timeMax


func registerTimeEvent(inTime: float, inMethod: Callable) -> void:
	if timeEvents.has(inTime):
		timeEvents[inTime].append(inMethod)
	else:
		timeEvents[inTime] = [inMethod]
		
	if nextTimeEvent > inTime:
		nextTimeEvent = inTime
