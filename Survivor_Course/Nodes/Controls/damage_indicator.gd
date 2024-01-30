extends Control
class_name DamageIndicator

@export var damageValue: float = 123.0

@export var duration: float = 0.7
var offsetDistance: float = 30.0

func _ready() -> void:
	%Number_Label.text = "%0.1f" % [damageValue]

	var tween = get_tree().create_tween().bind_node(self).set_parallel(true)
	tween.tween_property(self, "scale", Vector2.ONE * 1.5, duration * 0.5)
	tween.tween_property(self, "modulate", Color.RED, duration * 0.5)
	tween.chain().tween_property(self, "scale", Vector2.ZERO, duration * 0.5)
	tween.chain().tween_callback(self.queue_free)
	
	var tween_position = get_tree().create_tween().bind_node(self)
	tween_position.tween_property(self, "position", Vector2.UP * offsetDistance, duration).set_ease(Tween.EASE_IN)
	
	
func test() -> void:
	print("Test")
