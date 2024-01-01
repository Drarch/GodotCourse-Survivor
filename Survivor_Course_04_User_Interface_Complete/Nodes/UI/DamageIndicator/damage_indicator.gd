extends Control
class_name DamageIndicator

var duration:float = 0.7
@export var damageValue: float = 123.0

var offsetDistance: float = 30.0

func _ready():
	%Number_Label.text = str(round(damageValue))
	
	#var tween = get_tree().create_tween().bind_node(self)
	#tween.tween_interval(duration)
	#tween.tween_callback(self.queue_free)
	
	var tween = get_tree().create_tween().bind_node(self).set_parallel(true)
	tween.tween_property(self, "scale", Vector2.ONE * 1.5, duration * 0.5)
	tween.tween_property(self, "modulate", Color.RED, duration * 0.5).set_ease(Tween.EASE_IN)
	tween.chain().tween_property(self, "scale", Vector2.ZERO, duration * 0.5)
	tween.chain().tween_callback(self.queue_free)
	
	var tweenPosition = get_tree().create_tween().bind_node(self)
	tweenPosition.tween_property(self, "position", Vector2.UP* offsetDistance, duration)
