extends MeshInstance


# Declare member variables here. Examples:
# var a = 2
# var b = "text"


# Called when the node enters the scene tree for the first time.
func _ready():

	return 
	var st = SurfaceTool.new()

	var x = Vector3(4,1,6)

	# Material line width and vertex coloring doesn't work in Godot now, 
	# but vertext points do
	
	# we should also project the lines down to a horizontal plane (containing the plan view)
	# to act as the shadow rather than use shadow casting
	
	#st.begin(Mesh.PRIMITIVE_POINTS)
	st.begin(Mesh.PRIMITIVE_LINES)
	st.add_color(Color(0,1,0,1))	
	st.add_vertex(x+Vector3(0, 0, 0))
	st.add_color(Color(0,1,0,1))	
	st.add_vertex(x+Vector3(0, 3, 1))
	
	st.add_color(Color(0,1,0,1))	
	st.add_vertex(x+Vector3(0, 0, 0))
	st.add_color(Color(0,1,0,1))	
	st.add_vertex(x+Vector3(1, 1, 10))

	st.add_color(Color(0,0,1,1))
	st.add_vertex(x+Vector3(1, 1, 10))
	st.add_color(Color(0,0,1,1))
	st.add_vertex(x+Vector3(0, 0, 10))

	# Create indices, indices are optional.
	st.index()
	
	# Commit to a mesh.
	var mesh = st.commit()
  
	self.set_mesh(mesh)


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
