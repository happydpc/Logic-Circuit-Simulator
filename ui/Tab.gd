extends GraphEdit
onready var inspector = get_node("/root/main/RightTab/TabSelection/Tabs/Inspector")
var offset_data=scroll_offset
var selected_units:={}
var clipboard:={}
func _ready():
	#Removing unnecessary icons
	for i in range(3):
		self.get_zoom_hbox().get_child(i).visible=false
	self.get_zoom_hbox().set_anchors_and_margins_preset(Control.PRESET_TOP_RIGHT)
	self.get_zoom_hbox().rect_position-=Vector2(30,-10)
	
	self.add_child(GateConstructor.setup_gate("VAR"))
	self.add_child(GateConstructor.setup_gate("AND"))
	self.add_child(GateConstructor.setup_gate("AND"))
	self.add_child(GateConstructor.setup_gate("VAR"))
	self.add_child(GateConstructor.setup_gate("NOT"))
	self.add_child(GateConstructor.setup_gate("NOR"))
	self.add_child(GateConstructor.setup_gate("XOR"))
	
func _process(_delta):
	
	if get_global_mouse_position().x in range(self.rect_global_position.x,self.rect_global_position.x+self.rect_size.x) and \
	get_global_mouse_position().y in range(self.rect_global_position.y,self.rect_global_position.y+self.rect_size.y):
		var vector = (get_local_mouse_position()+scroll_offset)/zoom
		get_tree().get_root().get_node("main").get_node("BottomTab/HBoxContainer/Cursor").text="("+str(float(int(vector.x*10000))/10000)+", "+str(float(int(vector.y*10000))/10000)+")"
		
		if Input.is_action_just_released("middle_click") and self.visible:
			offset_data=self.scroll_offset
		if Input.is_action_just_released("zoom_in") and zoom>=0.60:
			self.zoom-=0.1
		elif Input.is_action_just_released("zoom_out") and zoom<=1.7:
			self.zoom+=0.1
		if Input.is_action_just_released("zoom_in") or  Input.is_action_just_released("zoom_out") and self.visible:
			self.scroll_offset=offset_data
			get_tree().get_root().get_node("main").get_node("BottomTab/HBoxContainer/Zoom").text=str(int(self.zoom*100))+"%"


func _on_Tab_node_selected(node):
	inspector.set_node(node)
	if !selected_units.has(node.name):
		selected_units[node.name]=node
		node.is_selected=true
		node.modulate.a=0.3

		get_tree().get_root().get_node("main").get_node("BottomTab/HBoxContainer/Selection").visible=true
		get_tree().get_root().get_node("main").get_node("BottomTab/HBoxContainer/IconSelection").visible=true
		get_tree().get_root().get_node("main").get_node("BottomTab/HBoxContainer/VSeparatorSelection").visible=true
		get_tree().get_root().get_node("main").get_node("BottomTab/HBoxContainer/Selection").text+=node.name
		var text=""
		var detailed_text=""
		var i = 0
		for key in selected_units.keys():
			if i<2:
				text+=key+", "
			i+=1
			detailed_text+=key+str(selected_units[key].offset)+"\n"
		if i>2:
			text+="+"+str(i-2)+"..."
			
		get_tree().get_root().get_node("main").get_node("BottomTab/HBoxContainer/Selection").text=text
		get_tree().get_root().get_node("main").get_node("BottomTab/HBoxContainer/IconSelection").hint_tooltip=detailed_text
		



func _on_Tab_node_unselected(node):
	node.is_selected=false
	node.modulate.a=1
	if selected_units.has(node.name):
		var _s1 = selected_units.erase(node.name)
	
	if selected_units.size()==0:
		inspector.reset_node()
		get_tree().get_root().get_node("main").get_node("BottomTab/HBoxContainer/Selection").text=""
		get_tree().get_root().get_node("main").get_node("BottomTab/HBoxContainer/IconSelection").hint_tooltip=""
		get_tree().get_root().get_node("main").get_node("BottomTab/HBoxContainer/Selection").visible=false
		get_tree().get_root().get_node("main").get_node("BottomTab/HBoxContainer/IconSelection").visible=false
		get_tree().get_root().get_node("main").get_node("BottomTab/HBoxContainer/VSeparatorSelection").visible=false


func _on_Tab_connection_request(from, from_port, to, to_port):
	print("connecting : ",from," ",from_port," to ",to," ",to_port)
	for iter in self.get_connection_list():
		if iter.to == to and iter.to_port == to_port:
			return
	var _s1 = self.connect_node(from, from_port, to, to_port)

	push_value(from,from_port)
	

func _on_Tab_disconnection_request(from, from_port, to, to_port):
	print("disconnecting",from,to)
	self.disconnect_node(from, from_port, to, to_port)
	get_node(to).calculate()
func _on_Tab_copy_nodes_request():
	clipboard=selected_units.duplicate(true)

func _on_Tab_paste_nodes_request():
	var node
	for iter in clipboard.keys():
		node = GateConstructor.setup_gate(clipboard[iter].gate_type)
		self.add_child(node)
		node.offset=clipboard[iter].offset+Vector2(40,40)
		_on_Tab_node_unselected(selected_units[iter])
		_on_Tab_node_selected(node)
	clipboard=selected_units.duplicate(true)


#void set_slot(idx: int, enable_left: bool, type_left: int, color_left: Color,
#enable_right: bool, type_right: int, color_right: Color, custom_left: Texture = null, custom_right: Texture = null)

func push_value(from:String,port:int):
	print("port is ",port)

	for iter in get_connection_list():
		if iter["from"]==from and iter["from_port"]==port:			
			print("connection("+from+","+iter.to+")\tdetails:",iter)
			var port_num=0
			for i in range(get_node(iter.to).get_child_count()):
				if get_node(iter.to).is_slot_enabled_left(i):
					if port_num==iter.to_port:
						get_node(iter.to).set_slot(i,get_node(iter.to).is_slot_enabled_left(i),0,get_node(from).get_connection_output_color(port),
						get_node(iter.to).is_slot_enabled_right(i),0,get_node(iter.to).get_slot_color_right(i))
						get_node(iter.to).calculate()
						break
					port_num+=1
			

