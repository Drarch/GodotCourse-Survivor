extends Label

func _ready():
	var parent: Node = get_parent()
	if is_instance_valid(parent):
		self.text = parent.name
