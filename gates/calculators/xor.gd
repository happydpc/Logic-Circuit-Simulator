extends Panel

func run(array : Array):
	if array.size()==2:
		return true if (array[0]!=array[1]) else false
	else:
		return false
