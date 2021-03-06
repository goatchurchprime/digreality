extends KinematicBody

const 		MOUSE_SENSITIVITY:float 	= 0.1
const  		GRAVITY:float				= -9.8
const 		ACCEL:float					= 8.0
const 		DEACCEL:float				= 16.0
onready var MAX_FLOOR_ANGLE:float 		= deg2rad(60)
export var	WALK_SPEED:float 			= 20.0
export var  JUMP_SPEED:float			= 15.0
export var	jump_is_jetpack:bool		= false
var   		velocity:Vector3			= Vector3()  # Current velocity direction

onready var	camera_pullback_tick:int 	= OS.get_ticks_msec()		# Pullback Timer
export var 	CAMERA_PULLBACK_DELAY		= 1000						# Wait this many ms before pulling back
export var 	CAMERA_POS_CLOSE:Vector3 	= Vector3(0, 0.3, 0)		# Vectors that the two settings below lerp between
export var 	CAMERA_POS_FAR:Vector3		= Vector3(0, 3.5, 7)
var			camera_max_lerp:float		= 1.0						# User set max lerp position between 0 and 1
var 	   	camera_pos_lerp:float		= 0.0						# Current lerp position between 0 and camera_max_lerp 


func _physics_process(delta):

	#### Update Player
	
	var direction = Vector3() 						# Where does the player want to move
	var facing_direction = global_transform.basis	# Get camera facing direction

	if Input.is_action_pressed("move_forward"):		# Fix: Can move around in the air, no momentum, so can also climb steep walls.
		direction -= facing_direction.z			
	if Input.is_action_pressed("move_backward"):
		direction += facing_direction.z
	if Input.is_action_pressed("move_left"):
		direction += -facing_direction.x
	if Input.is_action_pressed("move_right"):
		direction += +facing_direction.x
	if  Input.is_action_pressed("jump") and (jump_is_jetpack or is_on_floor()):
		velocity.y = JUMP_SPEED
	
	#direction.y = 0
	direction = direction.normalized()
	
	# Apply gravity to downward velocity
	velocity.y += delta*GRAVITY
	
	var hvelocity = velocity				# Apply desired direction to horizontal velocity
	hvelocity.y = 0
	
	var target = direction*WALK_SPEED
	var accel
	if (direction.dot(hvelocity) > 0):
		accel = ACCEL
	else:
		accel = DEACCEL
	
	hvelocity = hvelocity.linear_interpolate(target, accel*delta)
	
	velocity.x = hvelocity.x
	velocity.z = hvelocity.z

	velocity = move_and_slide(velocity, Vector3(0, 1, 0), true)


	
	#### Update Camera
	
	if camera_max_lerp>0:
		check_camera_bounds()
		


# If follow camera is on, and hits the terrain, pull it in closer to the player 
func check_camera_bounds():
	var space_state = get_world().direct_space_state
	var pos = $CamNode/Camera.global_transform.origin

	# Raycast two unit around camera for rudimentary collision detection. (Maybe switch Camera parent to physicsbody?)
	var result0 = space_state.intersect_ray(pos, pos + 2*$CamNode/Camera.global_transform.basis.z, [self])  # Behind
	var result1 = space_state.intersect_ray(pos, pos - 2*$CamNode/Camera.global_transform.basis.z, [self])  # Front
	var result2 = space_state.intersect_ray(pos, pos + 2*$CamNode/Camera.global_transform.basis.x, [self])	# Right
	var result3 = space_state.intersect_ray(pos, pos - 2*$CamNode/Camera.global_transform.basis.x, [self])	# Left
	var result4 = space_state.intersect_ray(pos, pos + 2*$CamNode/Camera.global_transform.basis.y, [self])	# Above
	var result5 = space_state.intersect_ray(pos, pos - 2*$CamNode/Camera.global_transform.basis.y, [self])	# Below

	if result0 or result1 or result2 or result3 or result4 or result5:
		camera_pos_lerp -= .025
		camera_pos_lerp = clamp(camera_pos_lerp, 0, camera_max_lerp)
		camera_pullback_tick = OS.get_ticks_msec()
		move_camera(camera_pos_lerp)

	else:
		if OS.get_ticks_msec() - camera_pullback_tick > CAMERA_PULLBACK_DELAY:
			camera_pos_lerp += .01
			camera_pos_lerp = clamp(camera_pos_lerp, 0, camera_max_lerp)
			move_camera(camera_pos_lerp)



func move_camera(lerp_val:float) -> void:
	var t = $CamNode/Camera.get_transform()
	var offset = CAMERA_POS_CLOSE.linear_interpolate(CAMERA_POS_FAR, lerp_val)
	t.origin = CAMERA_POS_CLOSE + offset
	$CamNode/Camera.set_transform(t)


func _input(event):
	
	if event is InputEventMouseButton and Input.is_mouse_button_pressed(BUTTON_WHEEL_UP):
		camera_max_lerp -= .1
		camera_max_lerp = clamp(camera_max_lerp, 0, 1)

	elif event is InputEventMouseButton and Input.is_mouse_button_pressed(BUTTON_WHEEL_DOWN):
		camera_max_lerp += .1
		camera_max_lerp = clamp(camera_max_lerp, 0, 1)
		
		
	elif event is InputEventMouseMotion and Input.get_mouse_mode() == Input.MOUSE_MODE_CAPTURED:
		
		# Rotate the camera around the player vertically
		$CamNode.rotate_x(deg2rad(-event.relative.y * MOUSE_SENSITIVITY * 0.90625))
		var rot = $CamNode.rotation_degrees
		rot.x = clamp(rot.x, -60, 85)
		$CamNode.rotation_degrees = rot

		# Rotate Player left and right
		self.rotate_y(deg2rad(event.relative.x * MOUSE_SENSITIVITY * -1))
