

func get_signals(node:Node, requested_method:Array[Callable] = [], show_lambdas := false) -> Dictionary:
	var found := {node: []}
	
	for SIGNAL in node.get_signal_list():
		for CONNECTION in node.get_signal_connection_list(SIGNAL["name"]):
				if requested_method.is_empty() and not show_lambdas:
					found[node].append(CONNECTION)
				elif CONNECTION["callable"] in requested_method or (show_lambdas and "<anonymous lambda>(lambda)" == str(CONNECTION["callable"])):
					found[node].append(CONNECTION)
	
	if found[node].is_empty(): found.erase(node)
	
	for i in node.get_children():
		found.merge(await get_signals(i, requested_method, show_lambdas))
	
	return found


func pos_to_grid(pos: Vector2i, grid_step := Vector2i(32, 32)):
	return Vector2(grid_step.x - pos.x % grid_step.x + pos.x, grid_step.y - pos.y % grid_step.y + pos.y)

