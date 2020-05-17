extends Spatial

# Called when the node enters the scene tree for the first time.
func _ready():
	# We will be using OpenVR to drive the VR interface, so we need to find i
	# Install from AssetLib Occulus Quest Toolkit (for quest) and OpenVR (for vive).

#	var VR = ARVRServer.find_interface("OpenVR");
#	if VR and VR.initialize():
#		print("VR initialized!!!")
#		get_viewport().arvr = true
#		get_viewport().hdr = false
#		
#		OS.vsync_enabled = false
#		Engine.iterations_per_second = 90
#	else:
#		print("Needs OpenVR module downloaded into assets")
		# also working through this tools tutorial  https://github.com/GodotVR/godot-xr-tools/wiki
		
	if false:
		vr.initialize();   # This comes in from OQToolkit Autoload

	if (vr.inVR):
		vr.set_foveation_level(0);
		vr.scene_switch_root = self;

	else:
		print("Not in VR");
		Input.set_mouse_mode(Input.MOUSE_MODE_CAPTURED)
	
	$ARVROrigin/ARVRController_Left.voxellodterrain = $VoxelLodTerrain
	$ARVROrigin/ARVRController_Left.voxeltool = $VoxelLodTerrain.get_voxel_tool()
	
# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass

func _input(event):
	if event is InputEventKey and Input.is_action_pressed("ui_cancel"):
		if Input.get_mouse_mode() == Input.MOUSE_MODE_VISIBLE:
			Input.set_mouse_mode(Input.MOUSE_MODE_CAPTURED)
		else:
			Input.set_mouse_mode(Input.MOUSE_MODE_VISIBLE)

