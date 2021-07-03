extends Panel

func run(array : Array):
	if array.size()>0:
		for i in range(array.size()):
			if !array[i]:
				return false
		return true
	else:
		return false
