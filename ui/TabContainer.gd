extends TabContainer

func _ready() -> void:
	get_node("../AcceptDialog").get_child(0).connect("pressed",self,"_on_AcceptDialog_cancelled")

func _on_TabContainer_tab_changed(tab) -> void:
	if self.get_tab_control(tab).name=="+":
		get_node("../BottomTab/HBoxContainer/CurrentTab").text="Create"
		get_node("../AcceptDialog/VBoxContainer/LineEdit").text=""
		get_node("../AcceptDialog/VBoxContainer/HBoxContainer/SpinBox").value=0
		get_node("../AcceptDialog/VBoxContainer/HBoxContainer/SpinBox2").value=0	
		get_node("../AcceptDialog/VBoxContainer/HBoxContainer").visible=get_node("../AcceptDialog/VBoxContainer/OptionButton").selected==1
		get_node("../AcceptDialog").popup()
	else:
		get_node("../BottomTab/HBoxContainer/CurrentTab").text=self.get_child(tab).name




func _on_AcceptDialog_confirmed() -> void:
	if get_node("../AcceptDialog/VBoxContainer/LineEdit").text==null or get_node("../AcceptDialog/VBoxContainer/LineEdit").text=="" \
	or get_node("../AcceptDialog/VBoxContainer/LineEdit").text=="+":
		OS.alert("Error while creating a tab. Invalid scene name.", "Error")
		self.current_tab=self.get_previous_tab()
	else :
		pass


func _on_AcceptDialog_cancelled() -> void:
		self.current_tab=self.get_previous_tab()
	


func _on_OptionButton_item_selected(index):
	get_node("../AcceptDialog/VBoxContainer/HBoxContainer").visible=index==1
