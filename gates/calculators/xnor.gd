extends Panel

func run(array : Array) -> bool:
	if array.size()==2:
		return false if (array[0]!=array[1]) else true
	else:	return false
