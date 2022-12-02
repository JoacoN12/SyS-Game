extends Area

var damage = 20.1
var player = load("res://FirstPerson2.tscn").instance()

func _on_Area_body_entered(body):
	if body.is_in_group("Player"):
		player.player_health -= damage
