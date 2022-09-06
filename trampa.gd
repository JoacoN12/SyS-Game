extends Area

func _on_trampa_body_entered(body):
	if body.name == "FirstPerson":
		get_tree().change_scene("res://muerte.tscn")
