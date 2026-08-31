extends Camera2D

var target: Node2D

func _ready() -> void:
	get_target()
	if target:
		make_current()      
		reset_smoothing()

func _physics_process(_delta: float) -> void:
	if target == null:
		return
	global_position = target.global_position

func get_target() -> void:
	var nodes := get_tree().get_nodes_in_group("Player")
	if nodes.is_empty():
		push_error("Player não encontrado no grupo 'Player'")
		return
	target = nodes[0]
