extends GraphNode
const gate_type = "VAR"
var time:=0
var is_selected:=false
func calculate():
	var result := []
	for iter in get_node("input").get_children():
		result.append(iter.value)
	result = get_node(gate_type).calculate(result)
	for i in range (result.size()):
		get_node("output").get_child(i).push_value(result[i])

func _on_CheckButton_toggled(button_pressed):
	pass
