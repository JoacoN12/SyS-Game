extends Area

func _on_boka_body_entered(body):
	if body.name == "FirstPerson2":
		get_node("boka").visible = not get_node("boka").visible

func _on_boka_body_exited(body):
	if body.name == "FirstPerson2":
		get_node("boka").visible = not get_node("boka").visible
