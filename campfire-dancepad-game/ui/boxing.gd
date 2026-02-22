extends Node

var grid_size = 3

@export var players: int = 2
@export var turn: int = 0

var target: Vector2i

@export var points_ui: PackedScene

var awaiting_input = true

func _ready() -> void:
	turn_intro()
	for i in players:
		var new_points = points_ui.instantiate()
		new_points.player_num = i + 1
		$"../CanvasLayer/Control/score".add_child(new_points)
	$"../CanvasLayer/Control/score".color_scoreboard(turn)

func show_score():
	pass

func turn_intro():
	show_target()
	if turn == players:
		get_tree().change_scene_to_file("res://ui/main_menu.tscn")
		return
	turn += 1
	$"../CanvasLayer/Control/ColorRect/Label".text = "player " + str(turn) + "'s turn"
	$"../CanvasLayer/Control/score".color_scoreboard(turn)
	$"../CanvasLayer/Control/ColorRect".show()
	await get_tree().create_timer(1.5).timeout
	$"../CanvasLayer/Control/ColorRect".hide()
	awaiting_input = true
	$"../round timer".start()


func _process(delta: float) -> void:
	#$"../CanvasLayer/Control/time".text = $"../round timer".t
	if awaiting_input:
		check_input()
	$"../CanvasLayer/Control/time".text = str(roundi($"../round timer".time_left))

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

func show_target():
	for z in $"../CanvasLayer/Control/GridContainer".get_children():
		z.modulate = Color(3.93, 0.0, 0.0) # Color.WHITE
	
	target = Vector2i(randi_range(1, grid_size), randi_range(1, grid_size))
	get_ui_square(target).modulate =  Color(0.0, 18.892, 0.0)

func hit(square):
	
	if square == target:
		#get_ui_square(turn - 1)
		$"../CanvasLayer/Control/score".get_child(turn - 1).add_points(1)
		$"../Node/goal".play()
		$"../Node2D/punch".hide()  
		$"../Node2D/hit".show()
	else:
		#$"../CanvasLayer/Control/score".get_child(turn - 1).add_points(-1)
		$"../Node/miss".play()
		$"../Node2D/punch".show()
		$"../Node2D/hit".hide()
	
	show_target()
	#awaiting_input = false
	#var was_blocked = false
	#for i in blocked:
		#if i == square:
			#was_blocked = true
			#print("blocked :(")
			#post_shot(square, 0)
			#break
#
		#post_shot(square, 1)

func get_ui_square(cords: Vector2i):
	for i in $"../CanvasLayer/Control/GridContainer".get_children():
		if cords == i.grid_cords:
			return i


func _on_round_timer_timeout() -> void:
	turn_intro()
	$"../Node/miss".play()
