extends Node2D

const A = 128 + 20
@onready var direction = Vector2.RIGHT

@export var parent_block: Node2D = null

var last_position = Vector2.ZERO

func _process(_delta):
	if not is_main_block(): return
	if Input.is_action_just_pressed("move_block_down"):
		direction = Vector2.DOWN
	elif Input.is_action_just_pressed("move_block_up"):
		direction = Vector2.UP
	elif Input.is_action_just_pressed("move_block_left"):
		direction = Vector2.LEFT
	elif Input.is_action_just_pressed("move_block_right"):
		direction = Vector2.RIGHT 

func _on_discrete_movement_timer_timeout():
	if is_main_block():
		last_position = position
		position += A * direction
	else:
		position = parent_block.get_last_position()

func is_main_block():
	return parent_block == null

func get_last_position():
	return last_position
