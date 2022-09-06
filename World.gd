extends Spatial

func _ready():
	var noise = OpenSimplexNoise.new()
	noise.period = 120
	noise.octaves = 4.5
	
	var plane_mesh = PlaneMesh.new()
	plane_mesh.size = Vector2(1200, 1200)
	plane_mesh.subdivide_depth = 200
	plane_mesh.subdivide_width = 200
	
	var surface_tool = SurfaceTool.new()
	surface_tool.create_from(plane_mesh, 0)
	
	var array_plane = surface_tool.commit()
	
	var data_tool = MeshDataTool.new()
	
	data_tool.create_from_surface(array_plane, 0)
	
	for i in range(data_tool.get_vertex_count()):
		var vertex = data_tool.get_vertex(i)
		vertex.y = noise.get_noise_3d(vertex.x, vertex.y, vertex.z) * 120
		
		data_tool.set_vertex(i, vertex)
		
	for i in range(array_plane.get_surface_count()):
		array_plane.surface_remove(i)
	data_tool.commit_to_surface(array_plane)
	surface_tool.begin(Mesh.PRIMITIVE_TRIANGLES)
	surface_tool.create_from(array_plane, 0)
	surface_tool.generate_normals()
	
	var mesh_instance = MeshInstance.new()
	mesh_instance.mesh = surface_tool.commit()
	mesh_instance.set_surface_material(0, load("res://shaderterrain.tres"))
	
	mesh_instance.create_trimesh_collision()
	
	add_child(mesh_instance)

onready var raycast = $FirstPerson/head/Camera/RayCast
onready var b_decal = preload("res://BulletDecal.tscn")
onready var pintura = $FirstPerson/head/Camera/Hand/pinturado

func _process(_delta):
	if Input.is_action_pressed("paint"):
		anim_paint.play("pintu")
		var b = b_decal.instance()
		if raycast.is_colliding():
			raycast.get_collider().add_child(b)
			b.global_transform.origin = raycast.get_collision_point()
			b.look_at(raycast.get_collision_point() + raycast.get_collision_normal(), Vector3.ONE)
			var target = raycast.get_collider()
			if target.is_in_group("enigazo"):
				pintura.play()

onready var anim_paint = $FirstPerson/head/Camera/Hand/AnimationPlayer2

onready var player = $FirstPerson
