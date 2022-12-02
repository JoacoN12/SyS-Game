extends RigidBody

var oro = 1
var player = load("res://FirstPerson2.tscn").instance()

func _on_CuboAreaOro_body_entered(body):
	if body.is_in_group("Player"):
		Global.oros += oro
		queue_free()
