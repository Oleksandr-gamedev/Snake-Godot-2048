extends Node2D

const DISTANCE_BETWEEN = 10.
const SIDE = 128. + DISTANCE_BETWEEN/2.
const SPEED = 100

@export var parent_block: Node2D = null
@export var last_cube = false

var last_positions = []

var origin_pos = Vector2.ZERO
var interp_pos = Vector2.ZERO

func _process(delta):
	if Input.is_action_just_pressed("start_timer"):
		$StorePosTimer.start()
	elif Input.is_action_just_pressed("stop_timer"):
		$StorePosTimer.stop()
	
	var direction = Vector2.ZERO
	if is_main_block():
		var mouse_pos = get_global_mouse_position()
		var v_dir = mouse_pos - position
	
		direction = Vector2.UP.rotated(-v_dir.angle_to(Vector2.UP))
		look_at(mouse_pos)
	
	if not is_main_block():
		if parent_block.shall_last_pos_be_removed(global_position):
			parent_block.remove_last_position()
			origin_pos = global_position
		
		var target_pos = parent_block.get_last_position()
		
		var AB = position.distance_to(origin_pos)
		var AC = origin_pos.distance_to(target_pos)

		var dir_vec = to_local(target_pos).rotated(rotation)
		direction = dir_vec.normalized()
		
		var pa = parent_block.get_prev_last_position()
		var pb = parent_block.get_last_position()
		interp_pos = bezier(pa, pb, global_position, AB/AC)

		look_at(interp_pos)
	
	position += direction * delta * SPEED

	queue_redraw()

func bezier(p0, p1, p2, t):
	return p0*t*t + p1*2*t*(1-t) + p2*(1-t)*(1-t)
	
func is_main_block():
	return parent_block == null

func get_last_position():
	if last_positions.is_empty():
		return global_position
	return last_positions.front()

func get_prev_last_position():
	if last_positions.size() < 2: return global_position
	return last_positions[1]

func shall_last_pos_be_removed(center_pos):
	if center_pos.distance_to(get_last_position()) < 15:
		return true
	return false

func remove_last_position():
	last_positions.pop_front()

func _on_store_pos_timer_timeout():
	if last_cube: return
	last_positions.append(global_position)
	
func _draw():
	draw_circle(Vector2.ZERO, 10, Color.RED)
	for x in last_positions:
		draw_circle(to_local(x), 3, Color.YELLOW_GREEN)
	if not is_main_block():
		#draw_line(Vector2.ZERO, to_local(parent_block.get_last_position()), Color.GREEN, 4)
		draw_circle(to_local(origin_pos), 3, Color.BLUE)
		draw_circle(to_local(interp_pos), 3, Color.WHITE)
