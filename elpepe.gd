extends KinematicBody

var speed
var default_move_speed = 50
var crouch_move_speed = 35
var crouch_speed = 25
var acceleration = 80
var gravity = 2
var jump = 60
var damage = 3

var default_height = 2.5
var crouch_height = 0.5

var mouse_sensitivity = 0.05

var direction = Vector3()
var velocity = Vector3()
var fall = Vector3() 

var noclip = false
var teleport = false
var telepoint = Vector3()
var telepoint_get = false

var phys_area_object
onready var phys_area = $head/Camera/Area
onready var phys_area_aim = $head/Camera/Area/aim
onready var head = $head
onready var pcap = $CollisionShape
onready var bonker = $HeadBonker
onready var aimcast = $head/Camera/RayCast
onready var anim = $head/Camera/Hand/AnimationPlayer
onready var feck = $head/Camera/Hand/fock
onready var chispazo = preload ("res://BloodSplatter.tscn")
onready var oof = $head/Camera/Hand/oof
onready var salto = $salto
onready var agachao = $agacho
onready var caminar = $caminar
onready var fucking = $head/Camera/Hand/fockudo
onready var patetas = $agache
onready var messi = $patasmessi
onready var telein = $head/Camera/teleported
onready var golpecito = preload("res://BulletDecal.tscn")

func _ready():
	Input.set_mouse_mode(Input.MOUSE_MODE_CAPTURED)

func _input(event):
	
	if event is InputEventMouseMotion:
		rotate_y(deg2rad(-event.relative.x * mouse_sensitivity)) 
		head.rotate_x(deg2rad(-event.relative.y * mouse_sensitivity))
		head.rotation.x = clamp(head.rotation.x, deg2rad(-89), deg2rad(89))
	
	if event.is_action_pressed("ojos"):
		get_node("head/Camera/elementos HUD/blanco y negro").visible = not get_node("head/Camera/elementos HUD/blanco y negro").visible
	
	if event.is_action_pressed("inverta"):
		get_node("head/Camera/elementos HUD/inverto").visible = not get_node("head/Camera/elementos HUD/inverto").visible
	
	if event.is_action_pressed("fallout"):
		get_node("head/Camera/elementos HUD/fallout").visible = not get_node("head/Camera/elementos HUD/fallout").visible
	
	if event.is_action_pressed("piecito1"):
		get_node(".").visible = not get_node(".").visible
		get_node("head/Camera/elementos HUD/FPScounter").visible = not get_node("head/Camera/elementos HUD/FPScounter").visible
		
	if event.is_action_pressed("settingextra"):
		get_node("head/Camera/elementos HUD/FPScounter").visible = not get_node("head/Camera/elementos HUD/FPScounter").visible
	
	if event.is_action_pressed("manito"):
		get_node("patas3").visible = not get_node("patas3").visible
		get_node("patas").visible = not get_node("patas").visible
	
	if event.is_action_pressed("killbind"):
		get_tree().reload_current_scene()

func _physics_process(delta):
	
	tele()	
	nocli()	

	var head_bonked = false
	
	speed = default_move_speed
	
	direction = Vector3()
	
	if bonker.is_colliding():
		head_bonked = true
	
	move_and_slide(fall, Vector3.UP, true, 4, 1)
	
	if Input.is_action_pressed("fire"):
		anim.play("fair")
		if aimcast.is_colliding():
			var target = aimcast.get_collider()
			if target.is_in_group("enigazo"):
				var b = chispazo.instance()
				b.global_transform.origin = target.global_transform.origin
				get_tree().get_root().add_child(b)
				print("hit enemy")
				target.health -= damage
				oof.play()

	if Input.is_action_just_pressed("agarre"):
		for body in phys_area.get_overlapping_bodies():
			if body is RigidBody:
				phys_area_object = body
				return
	if Input.is_action_just_released("agarre"):
			phys_area_object = null
	if Input.is_action_just_pressed("suelto") and phys_area_object != null and weakref(phys_area_object).get_ref():
		var a = phys_area_aim.get_global_transform().origin
		var b = phys_area_object.get_global_transform().origin
		
		phys_area_object.set_linear_velocity((b-a)*200)
		phys_area_object = null
	
	if phys_area_object != null and weakref(phys_area_object).get_ref():
		var a = phys_area.get_global_transform().origin
		var b = phys_area_object.get_global_transform().origin
		phys_area_object.set_linear_velocity((a-b)*15)
		if phys_area_object.get("timer") != null:
			phys_area_object.timer = 0

	if Input.is_action_just_pressed("fuck"):
		feck.play("fack")

	if not is_on_floor():
		fall.y -= gravity
	
	if Input.is_action_just_pressed("jump") and is_on_floor():
		salto.play()
		fall.y = jump
	
	if head_bonked: 
		fall.y = -2
	
	if Input.is_action_pressed("crouch"):
		pcap.shape.height -= crouch_speed * delta
		speed = crouch_move_speed
	elif not head_bonked: 
		pcap.shape.height += crouch_speed * delta
	
	if Input.is_action_pressed("crouch") and get_node("patas").visible:
			patetas.play("patosas")
	
	if Input.is_action_pressed("crouch") and get_node("patas3").visible:
			messi.play("soquete")
	
	if Input.is_action_just_pressed("crouch"):
		agachao.play()
		teleport = false
		telepoint_get = false
		gravity = 2
		get_node("CollisionShape").disabled= false
	
	pcap.shape.height = clamp(pcap.shape.height, crouch_height, default_height)
	
	if Input.is_action_pressed("move_forward"):
	
		direction -= transform.basis.z
	
	elif Input.is_action_pressed("move_backward"):
		
		direction += transform.basis.z
		
	if Input.is_action_pressed("move_left"):
		
		direction -= transform.basis.x			
		
	elif Input.is_action_pressed("move_right"):
		
		direction += transform.basis.x

	if Input.is_action_pressed("move_forward") and is_on_floor():
		caminar.play()

	elif Input.is_action_pressed("move_backward") and is_on_floor():
		caminar.play()
	
	if Input.is_action_pressed("move_left") and is_on_floor():
		caminar.play()
	
	elif Input.is_action_pressed("move_right") and is_on_floor():
		caminar.play()

	direction = direction.normalized()
	velocity = velocity.linear_interpolate(direction * speed, acceleration * delta) 
	
	var gravity_resistance = get_floor_normal() if is_on_floor() else Vector3.UP
	velocity -= gravity_resistance * gravity
	velocity = move_and_slide(velocity, Vector3.UP) 
	
	if Input.is_action_just_pressed("cerrrar"):
		get_tree().quit()
	
	if Input.is_action_just_pressed("cambiarpantalla"):
		OS.window_fullscreen = !OS.window_fullscreen
	
	var music_bus = AudioServer.get_bus_index("Master")
	if Input.is_action_just_pressed("mutear"):
		AudioServer.set_bus_mute(music_bus, not AudioServer.is_bus_mute(music_bus))

func nocli():
	if Input.is_action_just_pressed("noclip"):
		fall.y = 0
		gravity = -0
		get_node("CollisionShape").disabled= true

func tele():
	if Input.is_action_just_pressed("teleport"):
		if telein.is_colliding():
			if not teleport:
				teleport = true
				
	if teleport:
		fall.y = 1
		if not telepoint_get:
			telepoint = telein.get_collision_point() + Vector3(0, -15, 0)
			telepoint_get = true
		if telepoint.distance_to(transform.origin) > 1:
			if telepoint_get:
				transform.origin = lerp(transform.origin, telepoint, 0.8)
		else:
			teleport = false
			telepoint_get = false
