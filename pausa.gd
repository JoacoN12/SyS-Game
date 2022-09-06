extends CanvasLayer
 
func _ready():
	set_visible(false)

func _input(event):
	if event.is_action_pressed("pausa"):
		get_node("../negro").visible = not get_node("../negro").visible
		get_node("../azul").visible = not get_node("../azul").visible
		get_node("../PruebaCrosshair2").visible = not get_node("../PruebaCrosshair2").visible
		get_node("../quitdek").visible = not get_node("../quitdek").visible
		get_node("../quitmenu").visible = not get_node("../quitmenu").visible
		get_node("../Paused").visible = not get_node("../Paused").visible
		self.get_tree().paused = !self.get_tree().paused
		if Input.get_mouse_mode() == Input.MOUSE_MODE_CAPTURED:
			Input.set_mouse_mode(Input.MOUSE_MODE_VISIBLE)
		else:
			Input.set_mouse_mode(Input.MOUSE_MODE_CAPTURED)
	
	if event.is_action_pressed("piecito1"):
		get_node("../PruebaCrosshair2").visible = not get_node("../PruebaCrosshair2").visible

func set_visible(is_visible):
	for node in get_children():
		node.visible = is_visible

func _on_quitdek_pressed():
	self.get_tree().quit()

func _on_quitmenu_pressed():
	get_tree().change_scene("res://menuprincipal.tscn")
