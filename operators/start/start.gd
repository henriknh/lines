extends Operator

class_name Start

func _ready():
	add_to_group("Start")
	get_color_from_theme(get_tree().get_nodes_in_group("Start").size())

func _draw():
	var nb_points = 32
	var points_arc = PoolVector2Array()
	
	for i in range(nb_points + 1):
		var angle_point = deg2rad((360 / nb_points) * i)
		points_arc.push_back(Vector2(cos(angle_point), sin(angle_point)) * Level.operator_diameter / 2)
	
	draw_polygon(points_arc, [colors.background], [], null, null, true)
