extends Node2D
class_name NodeLifeCycle

@export var nodeScene: PackedScene
@export var addCount: int = 1

@export var positionOffset: Vector2 = Vector2(0, 150)

func _on_add_button_pressed():
	if !is_instance_valid(nodeScene):
		return
	
	var nodes: Array[Node2D] = []
	
	for i in range(addCount):
		var node: Node2D = nodeScene.instantiate() as Node2D
		node.position += i * positionOffset
		nodes.append(node)
		
	for n in nodes:
		%Nodes.add_child(n)
	
	
