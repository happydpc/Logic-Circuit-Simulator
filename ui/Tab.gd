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
	if self.visible:
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
		selected_units.erase(node.name)
	
	if selected_units.size()==0:
		inspector.reset_node()
		get_tree().get_root().get_node("main").get_node("BottomTab/HBoxContainer/Selection").text=""
		get_tree().get_root().get_node("main").get_node("BottomTab/HBoxContainer/IconSelection").hint_tooltip=""
		get_tree().get_root().get_node("main").get_node("BottomTab/HBoxContainer/Selection").visible=false
		get_tree().get_root().get_node("main").get_node("BottomTab/HBoxContainer/IconSelection").visible=false
		get_tree().get_root().get_node("main").get_node("BottomTab/HBoxContainer/VSeparatorSelection").visible=false


func _on_Tab_connection_request(from, from_port, to, to_port):
	for iter in self.get_connection_list():
		if iter.to == to and iter.to_port == to_port:
			return
	self.connect_node(from, from_port, to, to_port)
	
func add_node():
	var node := GraphNode.new()
	get_node("Graph").add_child(node)
	node.offset.x = get_viewport().get_mouse_position().x


func _on_Tab_disconnection_request(from, from_port, to, to_port):
	self.disconnect_node(from, from_port, to, to_port)



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
	
