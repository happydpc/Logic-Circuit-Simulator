extends TextEdit

func _ready():
	self.add_keyword_color("new","#e06b73")
	self.add_keyword_color("header","#e6c88f")
	self.add_keyword_color("import","#bc74d1")
	self.add_keyword_color("prefab","#bc74d1")
	self.add_keyword_color("scene","#bc74d1")
	
	#self.add_color_region("{","}","#7191a3",false)
	
	self.add_keyword_color("=>","#bb72d6")
	self.add_keyword_color("[","#bb72d6")
	self.add_keyword_color("]","#bb72d6")
	self.add_keyword_color("*","#bb72d6")
	
	self.add_color_region("\"","\"","#d6e379",true)
	self.add_color_region("'","'","#d6e379",true)
	self.add_color_region("/*","*/","#515660",false)
	self.add_color_region("//","","#515660",true)


func add_variable(keyword:String):
	self.add_keyword_color(keyword, "#6dac6b")

func _on_text_read():
	var error=false
	
	print( text.dedent().find("header:{"))
	if text.dedent().find("header:{")==-1:
		get_parent().get_node("RichTextLabel").push_color(Color.red)
		get_parent().get_node("RichTextLabel").add_text("> header property is not defined")
		error=true
	
