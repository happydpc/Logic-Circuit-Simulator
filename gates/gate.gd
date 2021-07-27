extends GraphNode

var gate_type:=""
var id:=0
var tag:=""
var legs:=0

# Place gates under GateControl with (0,-36)
func _ready() -> void:
	self.clear_all_slots()
	gate_type=get_node("GateControl").get_child(0).name.to_upper()
	resize_legs(2)
	var _result := calculate()

# Whenever an input changes the gate is called to calculate
func calculate() -> bool:
	var color:=Color.white
	var array=[]
	if self.get_connection_input_count()>0:
		for i in range(self.get_connection_input_count()):
			array.append(self.get_connection_input_color(i)==Color("#faf9a7"))
		var result = self.get_node("GateControl").get_child(0).run(array)
		color = Color("#faf9a7") if result else Color.white
		set_slot(2,is_slot_enabled_left(2),0,get_slot_color_left(2),true,0,color)
	else:
		set_slot(2,is_slot_enabled_left(2),0,get_slot_color_left(2),true,0,color)
	get_parent().push_value(self.name,0)
	return color!=Color.white
func resize_legs(value:int) -> void:
	if value<1 or value==legs:	return
	if  gate_type == "NOT" and value>1:
		resize_legs(1)
		return
	value = 5 if value>5 else value
	if legs!=0: print(self.name,".leg:=",value)
	legs=value
	self.set_slot(2,value % 2,0,self.get_slot_color_left(2),true,0,self.get_slot_color_right(2))
	self.set_slot(1, value > 1,0,self.get_slot_color_left(2),false,0,self.get_slot_color_right(2))
	self.set_slot(3, value > 1,0,self.get_slot_color_left(2),false,0,self.get_slot_color_right(2))
	self.set_slot(0,value>3,0,self.get_slot_color_left(2),false,0,self.get_slot_color_right(2))
	self.set_slot(4,value>3,0,self.get_slot_color_left(2),false,0,self.get_slot_color_right(2))
	
