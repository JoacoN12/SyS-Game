extends CanvasLayer

func _input(event):
	if event.is_action_pressed("pausa"):
		get_tree().paused = true
		get_node("../quitdek").visible = not get_node("../quitdek").visible
		get_node("../quitmenu").visible = not get_node("../quitmenu").visible
		if Input.get_mouse_mode() == Input.MOUSE_MODE_CAPTURED:
			Input.set_mouse_mode(Input.MOUSE_MODE_VISIBLE)
		else:
			Input.set_mouse_mode(Input.MOUSE_MODE_CAPTURED)

func _on_quitdek_pressed():
	self.get_tree().quit()

func _on_quitmenu_pressed():
	get_tree().change_scene("res://World.tscn")
