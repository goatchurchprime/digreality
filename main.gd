extends Spatial

# Called when the node enters the scene tree for the first time.
func _ready():
	# We will be using OpenVR to drive the VR interface, so we need to find it.
	var VR = ARVRServer.find_interface("OpenVR");
	if VR and VR.initialize():
		print("VR initialized!!!")
		get_viewport().arvr = true
		get_viewport().hdr = false
		
		OS.vsync_enabled = false
		Engine.iterations_per_second = 90
	else:
		print("Needs OpenVR module downloaded into assets")
		# also working through this tools tutorial  https://github.com/GodotVR/godot-xr-tools/wiki
		
	$ARVROrigin/ARVRController_Left.voxellodterrain = $VoxelLodTerrain
	
# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
