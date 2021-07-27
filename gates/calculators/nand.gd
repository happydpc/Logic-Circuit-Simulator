extends Panel

func run(array : Array) -> bool:
	if array.size()>0:
		for i in range(array.size()):
			if !array[i]:
				return true
		return false
	else:	return false
