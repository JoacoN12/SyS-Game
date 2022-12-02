extends MeshInstance

func _process(delta):
	var camera_pos = get_viewport().get_camera().global_transform.origin
	camera_pos.y = 0
	look_at(camera_pos, Vector3(0, 1, 0))
