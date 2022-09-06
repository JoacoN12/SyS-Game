extends RigidBody

var health = 5

func _physics_process(_delta):
	if health <-0:
		queue_free()
