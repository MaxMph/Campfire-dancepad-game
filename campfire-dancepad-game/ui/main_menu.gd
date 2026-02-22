extends Control

@export var next_scene: PackedScene

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if Input.is_action_just_pressed("start") or Input.is_action_just_pressed("ui_select"):
		if $TextureRect2.visible:
			$AnimationPlayer.play("click")
			await $AnimationPlayer.animation_finished
			$TextureRect2.hide()
			$VBoxContainer.show()
			#get_tree().change_scene_to_packed(next_scene)
		
	
	if $VBoxContainer.visible:
		if Input.is_action_just_pressed("middle_left"):
			$AudioStreamPlayer.play()
			await $AudioStreamPlayer.finished
			get_tree().change_scene_to_file("res://main.tscn")
		if Input.is_action_just_pressed("middle_right"):
			get_tree().change_scene_to_file("res://ui/boxing.tscn")
