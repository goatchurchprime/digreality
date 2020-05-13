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
		
	vr.initialize();
	#vdb.initialize();
	#vdb.load_global_statistics();
	#vdb.load_gameplay_settings();
	
	vr.set_foveation_level(0);
	
	vr.scene_switch_root = self;

	if (!vr.inVR): # for quick testing on desktop
		#vr.switch_scene("res://levels/MainWorld.tscn"); return;
		#vr.switch_scene("res://levels/MainMenuRoom.tscn"); return;
		#vr.switch_scene("res://levels/DungeonInstance.tscn"); return;
		print("Not in VR");

	#if vr.arvr_oculus_interface:
	#	$ARVROrigin/ARVRController_Left.buttoncontrolindex_trigger = 15
	#	$ARVROrigin/ARVRController_Left.buttoncontrolindex_touchpad = 14
	#	$ARVROrigin/ARVRController_Left.buttoncontrolindex_gripsqueeze = 2


	$ARVROrigin/ARVRController_Left.voxellodterrain = $VoxelLodTerrain
	$ARVROrigin/ARVRController_Left.voxeltool = $VoxelLodTerrain.get_voxel_tool()
	
	
# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
