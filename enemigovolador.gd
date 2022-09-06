extends KinematicBody

var health = 120

func _physics_process(_delta):
	if health <-0:
		queue_free()

export var speed = 2200
var space_state
var target

func _ready():
	space_state = get_world().direct_space_state

func _process(delta):
	if target:
		var result = space_state.intersect_ray(global_transform.origin, target.global_transform.origin)
		if result.collider.is_in_group("Player"):
			look_at(target.global_transform.origin, Vector3.UP)
			move_to_target(delta)

func _on_vision2_body_entered(body):
	if body.is_in_group("Player"):
		target = body

func _on_vision2_body_exited(body):
	if body.is_in_group("Player"):
		target = null

func move_to_target(delta):
	var direction = (target.transform.origin - transform.origin).normalized()
	move_and_slide(direction * speed * delta, Vector3.UP)
