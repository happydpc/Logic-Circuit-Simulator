extends Node

var base_gate=preload("res://gates/gate.tscn")
var gates={
	#"Output":preload("res://base nodes/output_gate.tscn"),
	#"Label":preload("res://base nodes/Label.tscn"),
	"VAR":preload("res://gates/calculators/var.tscn"),
#	#"Clock":preload("res://base nodes/clock.tscn"),
	"AND":preload("res://gates/calculators/and.tscn"),
	"NAND":preload("res://gates/calculators/nand.tscn"),
	"NOT": preload("res://gates/calculators/not.tscn"),
	"OR": preload("res://gates/calculators/or.tscn"),
	"NOR": preload("res://gates/calculators/nor.tscn"),
	"XOR": preload("res://gates/calculators/xor.tscn"),
	"XNOR": preload("res://gates/calculators/xnor.tscn")
}
func _ready():
	print("GateConstructor is loaded")
	randomize()

func setup_gate(gate_type:String):
	print("Setup : ",gate_type)
	var node
	if gate_type=="VAR" or gate_type=="Clock" or gate_type=="Label" or gate_type=="Output":
		node=gates[gate_type].instance()
	else:
		node=base_gate.instance()
		var gate=gates[gate_type].instance()
		node.gate_type=gate.name
		
		node.get_node("GateControl").add_child(gate)
		gate.rect_position.y=-36
	node.id=int(str(OS.get_unix_time()%10000)+str(randi()%10000))
	node.name = gate_type.to_lower()+str(node.id)
	return node
