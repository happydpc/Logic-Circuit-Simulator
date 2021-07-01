extends GraphNode
var gate_type:=""
var id:=0
var tag:=""
var time:=0
var is_selected:=false
var legs:=0
#gate updates the output
#Place gates under GateControl with (0,-36)
func _ready():
	self.clear_all_slots()
	gate_type=get_node("GateControl").get_child(0).name.to_upper()
	resize_legs(2)



#Whenever an input changes the gate is called to calculate
func calculate():
	var result := []
	for iter in get_node("input").get_children():
		result.append(iter.value)
	result = get_node(gate_type).calculate(result)
	for i in range (result.size()):
		get_node("output").get_child(i).push_value(result[i])

func resize_legs(value:int):
	if  gate_type == "NOT" and value>1:
		resize_legs(1)
		return
	if value>5 or value<1 or value==legs:
		return
	else:
		self.set_slot(2,value % 2,0,self.get_slot_color_left(2),true,0,self.get_slot_color_right(2),null,null)
		self.set_slot(1, value > 1,0,self.get_slot_color_left(2),false,0,self.get_slot_color_right(2),null,null)
		self.set_slot(3, value > 1,0,self.get_slot_color_left(2),false,0,self.get_slot_color_right(2),null,null)
		self.set_slot(0,value>3,0,self.get_slot_color_left(2),false,0,self.get_slot_color_right(2),null,null)
		self.set_slot(4,value>3,0,self.get_slot_color_left(2),false,0,self.get_slot_color_right(2),null,null)
	
