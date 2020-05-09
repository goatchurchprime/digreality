extends ARVRController


# Declare member variables here. Examples:
# var a = 2
# var b = "text"
var voxellodterrain; 
var repeattriggerrecharge = 0.0;
var worldscale = 1.0; 
var toolremoving = true; 

func _input(event):
	if event is InputEventKey and Input.is_key_pressed(KEY_Q):
		print("ggg", global_transform.origin, global_transform.basis.z)
			# var forward_direction = get_parent().get_node("Player_Camera").global_transform.basis.z.normalized()
		print(controller_id, [Input.get_joy_name(0), Input.get_joy_name(1), Input.get_joy_name(2), Input.get_joy_name(3), Input.get_joy_name(4)])
		
# Called when the node enters the scene tree for the first time.
func _ready():
	connect("button_pressed", self, "button_pressed")
	#connect("button_release", self, "button_released")
	worldscale = get_parent().world_scale

	
func _process(delta):
	repeattriggerrecharge = max(0, repeattriggerrecharge-delta)
	if is_button_pressed(15) and repeattriggerrecharge == 0 and voxellodterrain:  # trigger
		var vt = voxellodterrain.get_voxel_tool()
		print("vt", vt)
		vt.mode = VoxelTool.MODE_REMOVE if toolremoving else VoxelTool.MODE_ADD
		vt.value = 1
		var toolrad = $toolsphere.scale.x
		var sphpos = $toolsphere.global_transform.origin
		vt.do_sphere(sphpos, toolrad)
		repeattriggerrecharge = 0.3
		rumble = 1.0
	if repeattriggerrecharge <= 0.25:
		rumble = 0.0

func button_pressed(button_index):
	if button_index == 14:  # touchpad
		var j0 = get_joystick_axis(0)
		var j1 = get_joystick_axis(1)
		print("jj", j0, j1)
		var sphrad = pow(j0+2, 2)-0.5
		if abs(j1) < 0.2:
			var prevscale = $toolsphere.scale.x; 
			$toolsphere.scale.x = sphrad*worldscale; 
			$toolsphere.scale.y = sphrad*worldscale; 
			$toolsphere.scale.z = sphrad*worldscale; 
			print("set rad", $toolsphere.scale.x)
			$toolsphere.translation.z += prevscale - $toolsphere.scale.x 
			
		else:
			sphrad = $toolsphere.scale.x/worldscale

		if abs(j0) < 0.2:
			$toolsphere.translation.z = -(sphrad + pow(j1+1, 2))*worldscale 
			print("set transz", $toolsphere.translation.z)

	if button_index == 2:  # grip squeeze
		print("gripped!!!")
		toolremoving = !toolremoving
		$toolsphere.material_override.albedo_color = Color(0.26, 0.53, 0.91, 0.57) if toolremoving else Color(0.9, 0.0, 0.0, 0.57); 
# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
