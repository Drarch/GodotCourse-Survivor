extends MarginContainer
class_name DebugContainer

func _ready() -> void:
	Debug.connectLabel(%DebugLabel)


func _on_clear_button_pressed():
	%DebugLabel.clear()
