extends KinematicBody

var speed
var default_move_speed = 50
var crouch_move_speed = 35
var crouch_speed = 25
var acceleration = 80
var gravity = 2
var jump = 60
var damage = 3
var player_health = 100
var cheating = false

var default_height = 2.5
var crouch_height = 0.5

var mouse_sensitivity = 0.1

var direction = Vector3()
var velocity = Vector3()
var fall = Vector3() 

var noclip = false
var teleport = false
var telepoint = Vector3()
var telepoint_get = false
var deathening = false

var phys_area_object
onready var raycast = $head/Camera/RayCast
onready var b_decal = preload("res://BulletDecal.tscn")
onready var pintura = $head/Camera/Hand/pinturado
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
onready var po_musica = $head/Camera/elementosHUD/Playerhealthiconlowhealth/musicaa
onready var playerhealthtimer = $head/Camera/elementosHUD/Playerhealthiconlowhealth/PlayerHealthSong
var musicavidahecha = false
onready var caminete = $Movimientodecabeza
var danitopupa = false
onready var danojelly = $head/Camera/elementosHUD/Danopresente4
var danitorojo = false
onready var danorojoi = $head/Camera/elementosHUD/Danoojito
onready var rojoimdano = $head/Camera/elementosHUD/Danoojito/rojotim
onready var eughrojo = $head/Camera/elementosHUD/Danoojito/eughrojo
var muertanimation = false

func _ready():
	Input.set_mouse_mode(Input.MOUSE_MODE_CAPTURED)

func _input(event):
	
	if event is InputEventMouseMotion:
		rotate_y(deg2rad(-event.relative.x * mouse_sensitivity)) 
		head.rotate_x(deg2rad(-event.relative.y * mouse_sensitivity))
		head.rotation.x = clamp(head.rotation.x, deg2rad(-89), deg2rad(89))
	
	if event.is_action_pressed("ojos"):
		get_node("head/Camera/elementosHUD/blanco y negro").visible = not get_node("head/Camera/elementosHUD/blanco y negro").visible
	
	if event.is_action_pressed("piecito1"):
		get_node(".").visible = not get_node(".").visible
		get_node("head/Camera/elementosHUD/Playerhealthicon").visible = not get_node("head/Camera/elementosHUD/Playerhealthicon").visible
		get_node("head/Camera/elementosHUD/Label2").visible = not get_node("head/Camera/elementosHUD/Label2").visible
		get_node("head/Camera/elementosHUD/FPScounter").visible = not get_node("head/Camera/elementosHUD/FPScounter").visible
		get_node("head/Camera/elementosHUD/UIaccesorios").visible = not get_node("head/Camera/elementosHUD/UIaccesorios").visible
		get_node("head/Camera/elementosHUD/Oros").visible = not get_node("head/Camera/elementosHUD/Oros").visible
		get_node("head/Camera/elementosHUD/Control").visible = not get_node("head/Camera/elementosHUD/Control").visible
		get_node("head/Camera/elementosHUD/Oritossimbolos").visible = not get_node("head/Camera/elementosHUD/Oritossimbolos").visible
		
	if event.is_action_pressed("settingextra"):
		get_node("head/Camera/elementosHUD/FPScounter").visible = not get_node("head/Camera/elementosHUD/FPScounter").visible
	
	var pataschulas = false
	
	if event.is_action_pressed("manito") and pataschulas == true:
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
	
	if player_health <-0:
		if !muertanimation:
			muertanimation = true
			$PlayerBody/deathtimer.start()
			$PlayerBody/DeathAnimation.play("Deathanimation")
	
	if player_health <21:
		get_node("head/Camera/elementosHUD/Playerhealthiconlowhealth").show()
		get_node("head/Camera/elementosHUD/Danopresente4").show()
		if !musicavidahecha:
			musicavidahecha = true
			po_musica.play()
		if !danitorojo:
			danitorojo = true
			get_node("head/Camera/elementosHUD/Danoojito").show()
			get_node("head/Camera/elementosHUD/UIaccesorios/Passivedamageui").show()
			get_node("head/Camera/elementosHUD/UIaccesorios/Pinturadamagedui").show()
			rojoimdano.start()
			eughrojo.play()
		var deathening = true
		if deathening == true:
			speed = 65
			jump = 45
	
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
		caminete.play("saltocab")
	
	if head_bonked: 
		fall.y = -2
	
	if Input.is_action_pressed("crouch"):
		pcap.shape.height -= crouch_speed * delta
		speed = crouch_move_speed
	elif not head_bonked: 
		pcap.shape.height += crouch_speed * delta
	
	if Input.is_action_just_pressed("crouch") and get_node("patas").is_visible():
		$patas.hide()
		$patas2.show()
	
	if Input.is_action_just_released("crouch") and get_node("patas2").is_visible():
		$patas.show()
		$patas2.hide()
	
	if Input.is_action_just_pressed("crouch") and get_node("patas3").visible:
		$patas3.hide()
		$pataszules2.show()
	
	if Input.is_action_just_released("crouch") and get_node("pataszules2").visible:
		$patas3.show()
		$pataszules2.hide()
	
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
		caminete.play("movicabezi")

	elif Input.is_action_pressed("move_backward") and is_on_floor():
		caminar.play()
		caminete.play("movicabezi")
	
	if Input.is_action_pressed("move_left") and is_on_floor():
		caminar.play()
		caminete.play("movicabezi")
	
	elif Input.is_action_pressed("move_right") and is_on_floor():
		caminar.play()
		caminete.play("movicabezi")

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
	var musicv = AudioServer.get_bus_index("Music")
	var soundfx = AudioServer.get_bus_index("SFX")
	if Input.is_action_just_pressed("mutear"):
		AudioServer.set_bus_mute(music_bus, not AudioServer.is_bus_mute(music_bus))
		AudioServer.set_bus_mute(musicv, not AudioServer.is_bus_mute(musicv))
		AudioServer.set_bus_mute(soundfx, not AudioServer.is_bus_mute(soundfx))
	
	if Input.is_action_just_pressed("rightclick"):
		get_node("head/Camera/elementosHUD/UIaccesorios/Barritaguardado2").visible = not get_node("head/Camera/elementosHUD/UIaccesorios/Barritaguardado2").visible
		if Input.get_mouse_mode() == Input.MOUSE_MODE_CAPTURED:
			Input.set_mouse_mode(Input.MOUSE_MODE_VISIBLE)
		else:
			Input.set_mouse_mode(Input.MOUSE_MODE_CAPTURED)
	
	if Input.is_action_pressed("pausa"):
		get_tree().paused = true
		get_node("Paused/Pausebackgroundsys").visible = not get_node("Paused/Pausebackgroundsys").visible
		get_node("head/Camera/elementosHUD").visible = not get_node("head/Camera/elementosHUD").visible
		if Input.get_mouse_mode() == Input.MOUSE_MODE_CAPTURED:
			Input.set_mouse_mode(Input.MOUSE_MODE_VISIBLE)
		else:
			Input.set_mouse_mode(Input.MOUSE_MODE_CAPTURED)

func nocli():
	if Input.is_action_just_pressed("noclip") and cheating == true:
		fall.y = 0
		gravity = -0
		get_node("CollisionShape").disabled= true

func tele():
	if Input.is_action_just_pressed("teleport") and cheating == true:
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

func _on_rojotim_timeout():
	get_node("head/Camera/elementosHUD/Danoojito").hide()

var damage1 = 20.1
var oro = 1
var danorowe = false


func _on_efectuado_area_entered(area):
	if area.is_in_group("Cudano"):
		$".".player_health -= damage1
		$"head/Camera/elementosHUD/Dañopresente".show()
		$"head/Camera/elementosHUD/Dañopresente/danopresentetimer".start()
		$"head/Camera/elementosHUD/Dañopresente/danopresentesound".play()
	if area.is_in_group("Translate"):
		get_node("head/Camera/elementosHUD/Translate4").visible = not get_node("head/Camera/elementosHUD/Translate4").visible
		if Input.is_action_pressed("translate"):
			get_node("head/Camera/elementosHUD/Translate4").visible = not get_node("head/Camera/elementosHUD/Translate4").visible
			get_node("head/Camera/elementosHUD/Translate3").visible = not get_node("head/Camera/elementosHUD/Translate3").visible

func _process(_delta):
	if Input.is_action_pressed("paint"):
		anim_paint.play("pintu")
		var truepaint = 1
		var b = b_decal.instance()
		if truepaint == 1:
			if raycast.is_colliding():
				raycast.get_collider().add_child(b)
				b.global_transform.origin = raycast.get_collision_point()
				b.look_at(raycast.get_collision_point() + raycast.get_collision_normal(), Vector3.ONE)
				var target = raycast.get_collider()
				if target.is_in_group("enigazo"):
					pintura.play()

onready var anim_paint = $head/Camera/Hand/AnimationPlayer2


func _on_quitdek_pressed():
	self.get_tree().quit()

func _on_quitmenu_pressed():
	get_tree().paused = false
	$Paused/Pausebackgroundsys/quitmenu/quittimer.start()

func _on_quittimer_timeout():
	get_tree().change_scene("res://World.tscn")

func _on_backpause_pressed():
	get_tree().paused = false
	get_node("Paused/Pausebackgroundsys").visible = not get_node("Paused/Pausebackgroundsys").visible
	get_node("head/Camera/elementosHUD").visible = not get_node("head/Camera/elementosHUD").visible
	if Input.get_mouse_mode() == Input.MOUSE_MODE_CAPTURED:
		Input.set_mouse_mode(Input.MOUSE_MODE_VISIBLE)
	else:
		Input.set_mouse_mode(Input.MOUSE_MODE_CAPTURED)

func _on_deathtimer_timeout():
	get_tree().change_scene("res://muerte.tscn")

func _on_danopresentetimer_timeout():
	$"head/Camera/elementosHUD/Dañopresente".hide()


func _on_efectuado_area_exited(area):
	if area.is_in_group("Translate"):
		$head/Camera/elementosHUD/Translate3.hide()
		$head/Camera/elementosHUD/Translate4.hide()
