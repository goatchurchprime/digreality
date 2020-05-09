extends VoxelLodTerrain


# Declare member variables here. Examples:
# var a = 2
# var b = "text"


# Called when the node enters the scene tree for the first time.
func _ready():
	pass
	
var r = 1.0
func _input(event):
			
	if event is InputEventKey and Input.is_key_pressed(KEY_P):
		var vt = self.get_voxel_tool()
		print("vt", vt)
		vt.mode = VoxelTool.MODE_ADD
		vt.value = 1
		#elif(type == BULLET_TYPE.DELETE):
		#	vt.mode = VoxelTool.MODE_REMOVE
		#	vt.value = 0
		
		vt.do_sphere(Vector3(3,-2,5), r)
		r += 0.1

# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
