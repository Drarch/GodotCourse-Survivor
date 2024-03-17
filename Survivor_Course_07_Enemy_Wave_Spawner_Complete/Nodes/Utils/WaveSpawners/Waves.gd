extends Node
class_name Waves

@export var waves: Array[WaveSpawnerBase]
@export var wavesTimes: Array[Vector2i]

func _ready():
	for i in waves.size():
		var wave = waves[i]
		var waveTimes = wavesTimes[i]
			
		Gameplay.gameTimer.registerTimeEvent(waveTimes.x, wave.activateEvent)
		Gameplay.gameTimer.registerTimeEvent(waveTimes.y, wave.deactivateEvent)
		
