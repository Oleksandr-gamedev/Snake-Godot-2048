extends Node2D

const A = 128
@onready var direction = Vector2.RIGHT

func _process(_delta):
	if Input.is_action_just_pressed("move_block_down"):
		direction = Vector2.DOWN
	elif Input.is_action_just_pressed("move_block_up"):
		direction = Vector2.UP
	elif Input.is_action_just_pressed("move_block_left"):
		direction = Vector2.LEFT
	elif Input.is_action_just_pressed("move_block_right"):
		direction = Vector2.RIGHT 

func _on_discrete_movement_timer_timeout():
	position += A * direction
