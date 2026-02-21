extends Node

var grid_size = 3

var blocked = []
#var points_per = 1


@export var poses: Array[grid_res] = []
@export var pose: grid_res

@export var players: int = 4
@export var turn: int = 0

@export var points_ui: PackedScene

var awaiting_input = true

func _ready() -> void:
	reset()
	turn_intro()
	for i in players:
		var new_points = points_ui.instantiate()
		$"../CanvasLayer/Control/score".add_child(new_points)

func _process(delta: float) -> void:
	if awaiting_input:
		check_input()


func reset():
	rand_pose()
	blocked.clear()
	for i in pose.blocked:
		blocked.append(i)
	show_blocked()

func turn_intro():
	show_blocked()
	if turn == players:
		turn = 0
		reset()
	turn += 1
	$"../CanvasLayer/Control/ColorRect/Label".text = "player " + str(turn) + "'s turn"
	$"../CanvasLayer/Control/ColorRect".show()
	await get_tree().create_timer(1.5).timeout
	$"../CanvasLayer/Control/ColorRect".hide()
	awaiting_input = true

func rand_pose():
	 
	var new_pose = pose
	while new_pose == pose:
		new_pose = poses[randi_range(0, poses.size() - 1)]
	pose = new_pose

func check_input():
	var hit = null
	if Input.is_action_just_pressed("bottom_left"):
		hit(Vector2i(1,1))
	if Input.is_action_just_pressed("bottom_middle"):
		hit(Vector2i(2,1))
	if Input.is_action_just_pressed("bottom_right"):
		hit(Vector2i(3,1))
	if Input.is_action_just_pressed("middle_left"):
		hit(Vector2i(1,2))
	if Input.is_action_just_pressed("middle_middle"):
		hit(Vector2i(2,2))
	if Input.is_action_just_pressed("middle_right"):
		hit(Vector2i(3,2))
	if Input.is_action_just_pressed("top_left"):
		hit(Vector2i(1,3))
	if Input.is_action_just_pressed("top_middle"):
		hit(Vector2i(2,3))
	if Input.is_action_just_pressed("top_right"):
		hit(Vector2i(3,3))
	
	if Input.is_action_just_pressed("ui_select"):
		hit(Vector2i(1, 3))


func hit(square):
	awaiting_input = false
	var was_blocked = false
	for i in blocked:
		if i == square:
			was_blocked = true
			print("blocked :(")
			post_shot(square, 0)
			break
		#if was_blocked  == true:
			#break
	
	if was_blocked == false:
		#print("goal!")
		#points += 1#points_per
		#$"../CanvasLayer/Control/score/points 1".text = str(points) #str(points)
		post_shot(square, 1)
	#reset()

func post_shot(hit = Vector2i.ZERO, scored = -1):
	
	#blocked.clear()
	show_blocked()
	
	if hit != Vector2i.ZERO:
		if scored != -1:
			if scored == 1:
				print("goal!")
				$"../CanvasLayer/Control/score".get_child(turn - 1).add_points(1)
				get_ui_square(hit).modulate = Color(0.0, 18.892, 0.0)
				
			else:
				get_ui_square(hit).modulate = Color(18.892, 0.0, 0.0)
		
		print(get_ui_square(hit).modulate)
		
	await get_tree().create_timer(1).timeout
	turn_intro()
	#reset()
	


func get_ui_square(cords: Vector2i):
	#for i in grid_size:
		#for x in grid_size:
			#for z in $"../CanvasLayer/Control/GridContainer".get_children():
				#if z.grid_cords == Vector2i(x, z)
	
	for i in $"../CanvasLayer/Control/GridContainer".get_children():
		if cords == i.grid_cords:
			return i

func show_blocked():
	for z in $"../CanvasLayer/Control/GridContainer".get_children():
		z.modulate = Color.WHITE
	
	for i in blocked:
		get_ui_square(i).modulate = Color.BLACK 
		#print("colored")
		#for x in $"../CanvasLayer/Control/GridContainer".get_children():
			#if i == x.grid_cords:
				#x.modulate = Color.BLACK
