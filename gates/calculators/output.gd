extends GraphNode

const gate_type = "OUTPUT"
var id:=0
var tag:=""

func calculate() -> bool:
	get_node("CheckButton").pressed=get_slot_color_left(0)!=Color.white
	return self.get_node("CheckButton").pressed
