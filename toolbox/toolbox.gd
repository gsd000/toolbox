@tool
extends EditorPlugin

var vbox : VBoxContainer
var scb : Button
var ssb : Button
var scyb : Button
var scab : Button
var spb : Button

var rcb : Button
var rsb : Button
var rcyb : Button
var rcab : Button

var fpscb : Button

const S_CUBE = preload("res://addons/toolbox/shapes/static/s_cube.tscn")
const S_SPHERE = preload("res://addons/toolbox/shapes/static/s_sphere.tscn")
const S_CYLINDER = preload("res://addons/toolbox/shapes/static/s_cylinder.tscn")
const S_PLANE = preload("res://addons/toolbox/shapes/static/s_plane.tscn")
const S_CAPSULE = preload("res://addons/toolbox/shapes/static/s_capsule.tscn")

const R_CAPSULE = preload("res://addons/toolbox/shapes/rigid/r_capsule.tscn")
const R_CUBE = preload("res://addons/toolbox/shapes/rigid/r_cube.tscn")
const R_CYLINDER = preload("res://addons/toolbox/shapes/rigid/r_cylinder.tscn")
const R_SPHERE = preload("res://addons/toolbox/shapes/rigid/r_sphere.tscn")

const FPSCONTR = preload("res://addons/toolbox/controllers/fps_player.tscn")
func _enter_tree():
	# Create a VBoxContainer to hold both buttons
	vbox = VBoxContainer.new()
	vbox.name = "Toolbox"
	
	var static_shapes_label = Label.new() 
	static_shapes_label.text = "Static Shapes" 
	vbox.add_child(static_shapes_label)
	
	# Create and configure the "Add Static Cube" button
	scb = Button.new()
	scb.text = "Add Static Cube"
	scb.connect("pressed", Callable(self, "_instance_scene").bind(S_CUBE))
	vbox.add_child(scb)
	# Create and configure the "Add Static Sphere" button
	ssb = Button.new()
	ssb.text = "Add Static Sphere"
	ssb.connect("pressed", Callable(self, "_instance_scene").bind(S_SPHERE))
	vbox.add_child(ssb)
	
	scyb = Button.new()
	scyb.text = "Add Static Cylinder"
	scyb.connect("pressed", Callable(self, "_instance_scene").bind(S_CYLINDER))
	vbox.add_child(scyb)
	
	scab = Button.new()
	scab.text = "Add Static Capsule"
	scab.connect("pressed", Callable(self, "_instance_scene").bind(S_CAPSULE))
	vbox.add_child(scab)
	
	# Create and configure the "Add Static Cube" button
	spb = Button.new()
	spb.text = "Add Static Plane"
	spb.connect("pressed", Callable(self, "_instance_scene").bind(S_PLANE))
	vbox.add_child(spb)
	
	var rigid_shapes_label = Label.new() 
	rigid_shapes_label.text = "Rigid Shapes" 
	vbox.add_child(rigid_shapes_label)
	
	# Create and configure the "Add Static Cube" button
	rcb = Button.new()
	rcb.text = "Add Rigid Cube"
	rcb.connect("pressed", Callable(self, "_instance_scene").bind(R_CUBE))
	vbox.add_child(rcb)
	# Create and configure the "Add Static Sphere" button
	rsb = Button.new()
	rsb.text = "Add Rigid Sphere"
	rsb.connect("pressed", Callable(self, "_instance_scene").bind(R_SPHERE))
	vbox.add_child(rsb)
	
	rcyb = Button.new()
	rcyb.text = "Add Rigid Cylinder"
	rcyb.connect("pressed", Callable(self, "_instance_scene").bind(R_CYLINDER))
	vbox.add_child(rcyb)
	
	rcab = Button.new()
	rcab.text = "Add Rigid Capsule"
	rcab.connect("pressed", Callable(self, "_instance_scene").bind(R_CAPSULE))
	vbox.add_child(rcab)
	
	var controllers_label = Label.new() 
	controllers_label.text = "Controllers" 
	vbox.add_child(controllers_label)
	
	fpscb = Button.new()
	fpscb.text = "Add FPS Controller"
	fpscb.connect("pressed", Callable(self, "_instance_scene").bind(FPSCONTR))
	vbox.add_child(fpscb)
	
	# Add the VBoxContainer to the editor's dock
	add_control_to_dock(DOCK_SLOT_LEFT_BL, vbox)

func _exit_tree():
	# Remove the VBoxContainer from the dock and free the buttons
	remove_control_from_container(CONTAINER_SPATIAL_EDITOR_MENU, vbox)
	vbox.queue_free()

func _instance_scene(scene):
	var instance = scene.instantiate()
	var current_scene = get_tree().edited_scene_root
	if current_scene:
		current_scene.add_child(instance)
		instance.set_owner(current_scene)  # Make sure the instance is editable and visible in the scene tree
		instance.position = Vector3(0, 0, 0)  # Modify this as needed
		# Enable editable children 
		for child in instance.get_children(): 
			child.set_owner(current_scene)
			for child2 in child.get_children():
				child2.set_owner(current_scene)
	else:
		print("Error: No current scene found.")
