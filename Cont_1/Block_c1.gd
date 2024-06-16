extends Node2D

const DISTANCE_BETWEEN = 10
const SIDE = 128 + DISTANCE_BETWEEN/2

@onready var direction = Vector2.RIGHT
@onready var last_position = position
@onready var target_position = position + SIDE * direction

@export var parent_block: Node2D = null

func _process(delta):
	if Input.is_action_just_pressed("move_block_up"):
		direction = Vector2.UP
	elif Input.is_action_just_pressed("move_block_down"):
		direction = Vector2.DOWN
	elif Input.is_action_just_pressed("move_block_left"):
		direction = Vector2.LEFT
	elif Input.is_action_just_pressed("move_block_right"):
		direction = Vector2.RIGHT
		
	var t_fraction = 1.0 - $Timer.time_left / $Timer.wait_time
	position = last_position + (target_position - last_position) * t_fraction
	if not is_main_block():
		look_at(parent_block.position)

func _on_timer_timeout():
	last_position = position
	if is_main_block():
		target_position = position + SIDE * direction
	else:
		target_position = parent_block.get_last_position()

func is_main_block():
	return parent_block == null

func get_last_position():
	return last_position
