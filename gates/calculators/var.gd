extends GraphNode

const gate_type = "VAR"
var id:=0
var tag:=""

func calculate() -> void:
	set_value(get_node("CheckButton").pressed)

func set_value(button_pressed:bool) -> void:
	print(self.name," := ", str(button_pressed).to_lower(),";")
	get_node("CheckButton").pressed=button_pressed
	var color = Color("#faf9a7") if button_pressed else Color.white
	set_slot(0,is_slot_enabled_left(0),0,get_slot_color_right(0),true,0,color)

	get_parent().push_value(self.name,0)
