extends Operator

class_name Block

func _ready():
	add_to_group("Block")

func _draw():
	var nb_points = 4
	var points_arc = PoolVector2Array()
	
	for i in range(nb_points + 1):
		var angle_point = deg2rad((360 / nb_points) * i + -45)
		#points_arc.push_back(Vector2(cos(angle_point), sin(angle_point)) * Level.operator_diameter / 1.5)
		points_arc.push_back(Vector2(cos(angle_point), sin(angle_point)) * Level.operator_diameter)
	
	draw_polygon(points_arc, [Themes.theme.on_background], [], null, null, true)
