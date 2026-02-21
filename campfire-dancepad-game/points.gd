extends Control

var points = 0
var player_num

func _ready() -> void:
	%"points label".text = "P" + str(player_num) + ": " + str(points)


func add_points(a: int):
	points += 1
	%"points label".text = "P" + str(player_num) + ": " + str(points)
	if points >= 6:
		get_tree().change_scene_to_file("res://ui/main_menu.tscn")
