extends Node2D


# Called when the node enters the scene tree for the first time.
func _ready():
	$Block1.process_mode = Node.PROCESS_MODE_DISABLED
	$Block2.process_mode = Node.PROCESS_MODE_DISABLED
	$Block3.process_mode = Node.PROCESS_MODE_DISABLED
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if Input.is_action_just_pressed("start_process"):
		$Block1.process_mode = Node.PROCESS_MODE_INHERIT
		$Block2.process_mode = Node.PROCESS_MODE_INHERIT
		$Block3.process_mode = Node.PROCESS_MODE_INHERIT
	pass
