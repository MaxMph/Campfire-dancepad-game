extends Control

var points = 0

func _ready() -> void:
	pass


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass

func add_points(a: int):
	points += 1
	$"points 1".text = str(points)
	if points >= 6:
		get_tree().change_scene_to_file("res://ui/main_menu.tscn")
