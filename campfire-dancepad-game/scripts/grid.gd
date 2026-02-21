extends Node

@export var grid_size = 3#Vector2(3, 3)
#var grid: Array[Vector2i] = []
var blocked = []#[Vector2i(1,1), Vector2i(1,2), Vector2i(2,2)]
var points_per = 1

@export var pose: grid_res

var awaiting_input = true

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	for i in pose.blocked:
		blocked.append(i)


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	
	if awaiting_input:
		check_input()
	

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


func hit(square):
	var was_blocked = false
	for i in blocked:
		if i == square:
			was_blocked = true
			print("blocked :(")
			break
		#if was_blocked  == true:
			#break
	
	if was_blocked == false:
		print("goal!")
	

#func show_blocked():
	#for i in $"../CanvasLayer/Control/GridContainer".get_children()
	#for i in 9:
		#$"../CanvasLayer/Control/GridContainer".get_child()
#
#func create_grid():
	#for x in grid_size:
		#var grid_array_point = Vector2.ZERO
		#grid_array_point.x = x
		#for y in grid_size:
			#grid_array_point.y = y
