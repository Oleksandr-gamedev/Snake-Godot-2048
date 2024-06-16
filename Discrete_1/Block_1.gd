extends Node2D

const A = 128

func _on_discrete_movement_timer_timeout():
	position.x += A
