extends Camera2D
var base_loc=Vector2.ZERO
var start_loc=Vector2.ZERO
var mouse=0
func _ready():
	for i in get_node("../CanvasLayer").get_children():
		i.connect("mouse_entered",self,"_on_mouse_entered")
		i.connect("mouse_exited",self,"_on_mouse_exited")
func _physics_process(delta):
	UIHandler.mouse_position=get_global_mouse_position()
	get_node("../CanvasLayer/GridSeperator/CursorPosition").text="Cursor : ("+str(int(UIHandler.mouse_position.x))+","+str(int(UIHandler.mouse_position.y))+")"
	if Input.is_action_just_pressed("right_click"):
		start_loc=UIHandler.mouse_position
	if Input.get_action_strength("right_click") and UIHandler.mouse_position.distance_to(start_loc)>40:
		self.position+=UIHandler.mouse_position.direction_to(start_loc)*(UIHandler.mouse_position.distance_to(start_loc)*10*delta)
				#base_loc=UIHandler.mouse_position
	get_node("../CanvasLayer/Label").text=str(mouse)
	if mouse==0:
		if Input.is_action_just_released("zoom_in"):
			self.zoom.x += 0.25
			self.zoom.y += 0.25
		if Input.is_action_just_released("zoom_out") and self.zoom.x > 0.25 and self.zoom.y > 0.25:
			self.zoom.x -= 0.25
			self.zoom.y -= 0.25
		get_node("../CanvasLayer/GridSeperator/ZoomLevel").text="ZoomLevel : "+str(int(1/self.zoom.x*100))+"%"



func _on_mouse_entered():
	mouse+=1

func _on_mouse_exited():
	mouse-=1

