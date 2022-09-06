extends KinematicBody
 
export var gravity = -15.0
export var walk_speed = 8.0
export var run_speed = 16.0
export var jump_speed = 5.0
export var mouse_sensitivity = 0.0015
export var acceleration = 4.0
export var friction = 8.0
export var fall_limit = -1000.0
 
var pivot
 
var playable = true
var dir = Vector3.ZERO
var velocity = Vector3.ZERO
var speedlabel
var footstepPlayer
func _ready():
	pivot = $pivot
	footstepPlayer = $FootstepPlayer
	speedlabel = $"../../../speed"
	Input.set_mouse_mode(Input.MOUSE_MODE_CAPTURED)
	mouse_sensitivity *= $"../../".stretch_shrink
 
func _physics_process(delta):
	dir = Vector3.ZERO
	var basis = global_transform.basis
	if Input.is_action_pressed("move_forward"):
		dir -= basis.z
	if Input.is_action_pressed("move_back"):
		dir += basis.z
	if Input.is_action_pressed("move_left"):
		dir -= basis.x
	if Input.is_action_pressed("move_right"):
		dir += basis.x
	dir = dir.normalized()
 
	var speed = walk_speed
	if is_on_floor():
		#this prevents you from sliding without messing up the is_on_ground() check
		velocity.y += gravity * delta / 100.0
		if Input.is_action_pressed("run"):
			speed = run_speed
		if Input.is_action_pressed("jump"):
			velocity.y = jump_speed
	else:
		velocity.y += gravity * delta
 
	var hvel = velocity
	hvel.y = 0.0
 
	var target = dir * speed
	var accel
 
	
	
	if is_on_floor() and !Input.is_action_pressed("jump"):
		accel = friction 
		hvel = hvel.linear_interpolate(target, accel * delta)
	else:
		if dir.dot(hvel) > 0: #not sudden turn
			accel = 0
		else :
			if !Input.is_action_pressed("move_forward"):
				print("air strafe:", (hvel.dot(dir)) )
				hvel += dir * (walk_speed-(hvel.dot(dir))) * 15 * delta
			else:
				accel = friction
				hvel = hvel.linear_interpolate(target, accel * delta)
 
 
 
	velocity.x = hvel.x
	velocity.z = hvel.z
	if playable:
		velocity = move_and_slide(velocity, Vector3.UP, false)
		var _vel = velocity
		_vel.y = 0
		var _hvel = _vel.length()
		if _hvel>0.1 and is_on_floor():
			if !footstepPlayer.playing:
				footstepPlayer.play()
				print(footstepPlayer.playing)
		speedlabel.text = String(_hvel) +"   fps:" + str(Performance.get_monitor(Performance.TIME_FPS))
 
	#prevents infinite falling
	if translation.y < fall_limit and playable:
		playable = false
		fader._reload_scene()
 
func _unhandled_input(event):
	if event is InputEventMouseMotion and playable:
		rotate_y(-event.relative.x * mouse_sensitivity)
		pivot.rotate_x(-event.relative.y * mouse_sensitivity)
		pivot.rotation.x = clamp(pivot.rotation.x, -1.2, 1.2)
 
 
 
