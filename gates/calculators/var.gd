extends GraphNode
const gate_type = "VAR"
var id:=0
var tag:=""
var time:=0
var is_selected:=false
func calculate():
	var result := []
	for iter in get_node("input").get_children():
		result.append(iter.value)
	result = get_node(gate_type).calculate(result)
	for i in range (result.size()):
		get_node("output").get_child(i).push_value(result[i])

func set_value(button_pressed:bool):
	get_node("CheckButton").pressed=button_pressed
	print(button_pressed)
