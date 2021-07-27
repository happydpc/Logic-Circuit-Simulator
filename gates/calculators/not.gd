extends Panel

func run(array : Array) -> bool:
	return !array[0] if !array.empty() else false
