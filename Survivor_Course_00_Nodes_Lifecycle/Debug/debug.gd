extends Node

const endLine: String = "\n"

var debugLabel: RichTextLabel

func connectLabel(inLabel: RichTextLabel) -> void:
	debugLabel = inLabel

func printLine(inText: String, inColor: Color = Color.WHITE) -> void:
	var timeString = _getTimeString()
	var message = "%s: %s" % [timeString, inText]
	print(message)
	
	if !is_instance_valid(debugLabel):
		return
	
	debugLabel.push_color(inColor)
	debugLabel.add_text(message + endLine)

func _getTimeString() -> String:
	var miliseconds: int = Time.get_ticks_msec()
	var seconds: int = int(miliseconds / 1000.0)
	var minutes: int = int(seconds / 60.0)
	miliseconds %= 1000
	
	return "%02d:%02d,%03d" % [minutes, seconds, miliseconds]
	
