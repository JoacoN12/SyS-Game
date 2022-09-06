extends StaticBody

var health = 100

func _physics_process(_delta):
	if health <-0:
		queue_free()
