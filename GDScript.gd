
func get_signals(node:Node, requested_method:Array[Callable] = [], show_lambdas := false)  -> Dictionary:
	var found := {node: []}

	for SIGNAL in node.get_signal_list():
		for CONNECTION in node.get_signal_connection_list(SIGNAL["name"]):
				if requested_method.is_empty() and not show_lambdas:
					found[node].append(CONNECTION)
					continue
        
				if CONNECTION["callable"] in requested_method or (show_lambdas and "<anonymous lambda>(lambda)" == str(CONNECTION["callable"])):
					found[node].append(CONNECTION)
  
	if found[node].is_empty(): found.erase(node)
  
	for i in node.get_children():
		found.merge(await get_signals(i, requested_method, show_lambdas))
  
	return found


func pos_to_grid(node:Node, grid_step := Vector2(32, 32):
  var pos:Vector2 = node.position
  node.position = Vector2((grid_step - int(pos.x) % grid_step) + int(pos.x) , (grid_step - int(pos.y) % grid_step) + int(pos.y))






  
