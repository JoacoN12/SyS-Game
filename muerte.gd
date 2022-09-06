extends CanvasLayer

func _on_quitmenu_pressed():
	get_tree().change_scene("res://menuprincipal.tscn")

func _on_restart_pressed():
	get_tree().change_scene("res://World.tscn")

func _input(event):
	if Input.get_mouse_mode() == Input.MOUSE_MODE_CAPTURED:
		Input.set_mouse_mode(Input.MOUSE_MODE_VISIBLE)
