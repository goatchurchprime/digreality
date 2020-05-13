extends ARVRController


# Declare member variables here. Examples:
# var a = 2
# var b = "text"
var voxellodterrain; 
var voxeltool; 
var voxeltooleditable = false; 

var repeattriggerrecharge = 0.0;
var rumblecountdown = 0.0; 
var worldscale = 1.0; 
var toolstate = 1;  # 0 hidden, 1 remove, 2 add

var sphererad = 2; 
var spherepos = 2; 



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
	

func altertoolstate(incval):
		toolstate = (toolstate + incval) % 3
		$toolsphere.visible = (toolstate != 0)
		if voxeltooleditable:
			$toolsphere.material_override.albedo_color = Color(0.26, 0.53, 0.91, 0.57) if (toolstate == 1) else Color(0.9, 0.0, 0.0, 0.57); 
		else:
			$toolsphere.material_override.albedo_color = Color(0.26, 0.93, 0.21, 0.57)
			

# settings for vive (reset for quest)
var buttoncontrolindex_trigger = 15
var buttoncontrolindex_touchpad = 14
var buttoncontrolindex_gripsqueeze = 2

# buttons for quest are here: https://github.com/NeoSpark314/godot_oculus_quest_toolkit/blob/master/OQ_Toolkit/vr_autoload.gd#L134	
func _process(delta):
	repeattriggerrecharge = max(0, repeattriggerrecharge-delta)
	
	if is_button_pressed(buttoncontrolindex_trigger) and repeattriggerrecharge == 0 and toolstate != 0 and voxellodterrain:  # trigger
		var vt = voxeltool # voxellodterrain.get_voxel_tool()
		vt.mode = VoxelTool.MODE_REMOVE if (toolstate == 1) else VoxelTool.MODE_ADD
		vt.value = 1
		vt.do_sphere($toolsphere.global_transform.origin, $toolsphere.scale.x)
		repeattriggerrecharge = 0.3
		rumblecountdown = 0.05
		
	rumblecountdown = max(0, rumblecountdown-delta)
	rumble = 0.0 if rumblecountdown == 0 else 1.0
	var prevvoxeltooleditable = voxeltooleditable
	voxeltooleditable = true # function does not exist:  voxeltool.is_area_editable()
	if prevvoxeltooleditable != voxeltooleditable:
		altertoolstate(0)
	
func button_pressed(button_index):
	if button_index == buttoncontrolindex_touchpad:  # touchpad
		var j0 = get_joystick_axis(0)
		var j1 = get_joystick_axis(1)
		var dsphererad = -1 if j0 < -0.5 else 1 if j0 > 0.5 else 0.0
		var dspherepos = -1 if j1 < -0.5 else 1 if j1 > 0.5 else 0.0
		rumblecountdown = 0.0 if dsphererad and dspherepos else 0.03
		sphererad = clamp(sphererad + dsphererad*0.5, 0.5, 5.0)
		spherepos = clamp(spherepos + dspherepos*0.5, 1.0, 8.0)
		$toolsphere.scale.x = sphererad*worldscale; 
		$toolsphere.scale.y = sphererad*worldscale; 
		$toolsphere.scale.z = sphererad*worldscale; 
		$toolsphere.translation.z = -(sphererad + spherepos)*worldscale
		print("sphere radpos", sphererad, spherepos)
		
	if button_index == buttoncontrolindex_gripsqueeze:  # grip squeeze
		altertoolstate(1)
