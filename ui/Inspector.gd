extends VBoxContainer
var node=null
func _ready():
	reset_node()
func set_node(obj):
	
	self.node=obj
	get_node("ObjectName").placeholder_text=node.tag if node.tag!="" else node.name
	get_node("Id/Value").text = str(node.id)
	get_node("Type/Value").text = node.gate_type.to_upper()
	if node.gate_type.to_lower()=="var":
		get_node("Value/Value").pressed = node.get_node("CheckButton").pressed
	#get_node("Interval/Value").text = node.id
	get_node("Position_x/Value").placeholder_text = str(node.offset.x)
	get_node("Position_y/Value").placeholder_text = str(node.offset.y)
	
	get_node("Source/Value").text = node.source if node.gate_type.to_lower()=="prefab" else "local://"
		
	get_node("ObjectName").editable=true
	get_node("Interval/Value").editable=true
	get_node("Position_x/Value").editable=true
	get_node("Position_y/Value").editable=true
	get_node("Value/Value").disabled=node.gate_type.to_lower()!="var"
	get_node("Source/Value").disabled=node.gate_type.to_lower()!="prefab"
	
	get_node("Interval").visible=node.gate_type.to_lower()=="clock"
	get_node("Value").visible=node.gate_type.to_lower()!="prefab"
	get_node("Timer").start()
	


func reset_node():
	node=null
	get_node("ObjectName").placeholder_text=""
	get_node("Id/Value").text = ""
	get_node("Type/Value").text = ""
	get_node("Value/Value").pressed = false 
	get_node("Interval/Value").text = ""
	get_node("Interval/Value").placeholder_text = ""
	get_node("Position_x/Value").text = ""
	get_node("Position_y/Value").text = ""
	get_node("Position_x/Value").placeholder_text = ""
	get_node("Position_y/Value").placeholder_text = ""
	get_node("Source/Value").text="local://"
	
	get_node("ObjectName").editable=false
	get_node("Interval/Value").editable=false
	get_node("Position_x/Value").editable=false
	get_node("Position_y/Value").editable=false
	get_node("Value/Value").disabled=true
	get_node("Source/Value").disabled=true
	
	
	get_node("Interval").visible=true
	get_node("Value").visible=true



func _on_refresh():
	if node!=null:
		set_node(node)
	else:
		get_node("Timer").stop()
		reset_node()

func _on_ObjectName_text_entered(new_text):
	if node!=null and new_text.dedent()!="":
		node.tag=new_text.dedent()
	get_node("ObjectName").text=""
		

func _on_Value_toggled(button_pressed):
	if node!=null:
		if node.gate_type.to_lower()=="var":
			node.set_value(button_pressed)



func _on_Position_text_entered(new_text):
	if node!=null and new_text.is_valid_integer():
		var point=Vector2.ZERO
		point.x = float(get_node("Position_x/Value").text) if get_node("Position_x/Value").text!="" else float(get_node("Position_x/Value").placeholder_text)
		point.y = float(get_node("Position_y/Value").text) if get_node("Position_y/Value").text!="" else float(get_node("Position_y/Value").placeholder_text)
		node.offset=Vector2(point.x,point.y)
		get_node("Position_x/Value").text =""
		get_node("Position_y/Value").text =""	
	else:
		get_node("Position_x/Value").text =""
		get_node("Position_y/Value").text =""

