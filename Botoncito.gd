extends Spatial

func _on_BotonArea_body_entered(body):
	if body.name == "FirstPerson2":
		get_node("Partidotonces").visible = not get_node("Partidotonces").visible

func _on_BotonArea_body_exited(body):
	if body.name == "FirstPerson2":
		get_node("Partidotonces").visible = not get_node("Partidotonces").visible
