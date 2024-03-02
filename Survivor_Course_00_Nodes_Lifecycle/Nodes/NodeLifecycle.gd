extends Node2D

const staticName: String = "Node2D"

@export var debugColor: Color = Color.WHITE
@export var debugLifecycle: bool = true
@export var debugInput: bool = false
@export var debugNotification: bool = false

static func _static_init():
	Debug.printLine("%s: _static_init()" % [staticName], Color.WHITE)
	


func _init():
	if debugLifecycle:
		Debug.printLine("%s: _init()" % [self.name], debugColor)
	

func _ready():
	if debugLifecycle:
		Debug.printLine("%s: _ready()" % [self.name], debugColor)
	%Name_Label.text = self.name


func _enter_tree():
	if debugLifecycle:
		Debug.printLine("%s: _enter_tree()" % [self.name], debugColor)


func _exit_tree():
	if debugLifecycle:
		Debug.printLine("%s: _exit_tree()" % [self.name], debugColor)


func _input(event: InputEvent):
	if !debugInput:
		return
	
	Debug.printLine("%s: _input(%s)" % [self.name, event.get_class()], debugColor)


func _notification(what: int):
	if !debugNotification:
		return
	
	var whatString = _getNotificationString(what)
	Debug.printLine("%s: _notification(%s)" % [self.name, whatString], debugColor)


func _getNotificationString(inNotification: int) -> String:
	var result: String = str(inNotification)
	
	match inNotification:
		NOTIFICATION_POSTINITIALIZE: #0
			result = "NOTIFICATION_POSTINITIALIZE"
		NOTIFICATION_PREDELETE: #1
			result = "NOTIFICATION_PREDELETE"
		
		NOTIFICATION_ENTER_TREE: #10
			result = "NOTIFICATION_ENTER_TREE"
		NOTIFICATION_EXIT_TREE: #11
			result = "NOTIFICATION_EXIT_TREE"
		NOTIFICATION_READY: #13
			result = "NOTIFICATION_READY"
		NOTIFICATION_PARENTED: #18
			result = "NOTIFICATION_PARENTED"
		NOTIFICATION_UNPARENTED: #19
			result = "NOTIFICATION_UNPARENTED"
		NOTIFICATION_CHILD_ORDER_CHANGED: #24
			result = "NOTIFICATION_CHILD_ORDER_CHANGED"
		NOTIFICATION_POST_ENTER_TREE: #27
			result = "NOTIFICATION_POST_ENTER_TREE"
		NOTIFICATION_DRAW: #30
			result = "NOTIFICATION_DRAW"	
		NOTIFICATION_VISIBILITY_CHANGED: #31
			result = "NOTIFICATION_VISIBILITY_CHANGED"
		NOTIFICATION_ENTER_CANVAS: #32
			result = "NOTIFICATION_ENTER_CANVAS"
		NOTIFICATION_EXIT_CANVAS: #33
			result = "NOTIFICATION_EXIT_CANVAS"
			
		NOTIFICATION_WM_MOUSE_ENTER: #1002
			result = "NOTIFICATION_WM_MOUSE_ENTER"
		NOTIFICATION_WM_MOUSE_EXIT: #1002
			result = "NOTIFICATION_WM_MOUSE_EXIT"
		
		NOTIFICATION_TRANSFORM_CHANGED: #2000
			result = "NOTIFICATION_TRANSFORM_CHANGED"

	
	return result


func _on_free_button_pressed():
	self.queue_free()
 
