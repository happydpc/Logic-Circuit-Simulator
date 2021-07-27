extends Panel

func run(array : Array) -> bool:
	return !array[0] if array.size()>0 else false
