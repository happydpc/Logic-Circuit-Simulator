extends Control

var data = {}
var time=0

func _ready() -> void:
	get_tree().set_auto_accept_quit(false)
	# Center window on screen
	var screen_size = OS.get_screen_size(OS.get_current_screen())
	var window_size = OS.get_window_size()
	var centered_pos = (screen_size - window_size) / 2
	OS.set_window_position(centered_pos)
	# Note: not tested on mobile platforms,
	# should do nothing in that case because it's fullscreen anyway
	
func _process(delta) -> void:
	time+=delta*10

func _notification(what) -> void:
	var is_saved := true
	if what == MainLoop.NOTIFICATION_WM_QUIT_REQUEST:
		for iter in get_node("../TabContainer").get_children():
			if iter.name!="+" and !iter.is_saved:
				OS.alert("There are some unsaved changes on "+iter.name, "Warning!")
				is_saved=false
				break	
#		print("Saving data")
#		var data_file = File.new()
#		data_file.open("res://data.json", File.WRITE)
#		data_file.store_string(to_json(data))
#		data_file.close()
		if is_saved:
			get_tree().quit()
