extends HBoxContainer


func _ready() -> void:
	pass


func _process(delta: float) -> void:
	pass

func color_scoreboard(turn: int):
	for i in get_children():
		i.modulate = Color.WHITE
	#$"../CanvasLayer/Control/score".get_child(turn - 1).modulate = Color(0.0, 3.705, 0.0)
	for i in get_children():
		if i.player_num == turn:
			i.modulate = Color(0.0, 3.705, 0.0)
