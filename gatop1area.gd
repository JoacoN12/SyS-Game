extends Area

func _on_gatop1area_body_entered(body):
	if body.name == "FirstPerson2":
		get_node("../textogatop1").visible = not get_node("../textogatop1").visible

func _on_gatop1area_body_exited(body):
	if body.name == "FirstPerson2":
		get_node("../textogatop1").visible = not get_node("../textogatop1").visible
