extends Spatial

onready var particles = $Particles

func _ready():
	particles.emitting = true

func _process(_delta):
	if not particles.emitting:
		queue_free()
