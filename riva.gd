extends Area

func _on_riva_body_entered(body):
	if body.name == "FirstPerson":
		get_node("riv").visible = not get_node("riv").visible

func _on_riva_body_exited(body):
	if body.name == "FirstPerson":
		get_node("riv").visible = not get_node("riv").visible
