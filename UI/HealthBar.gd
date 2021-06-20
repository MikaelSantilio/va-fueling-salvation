extends Control


func draw_circle_arc(center, radius, angle_from, angle_to, color):
	var nb_points = 32
	var points_arc = PoolVector2Array()

	for i in range(nb_points + 1):
		var angle_point = deg2rad(angle_from + i * (angle_to-angle_from) / nb_points - 90)
		points_arc.push_back(center + Vector2(cos(angle_point), sin(angle_point)) * radius)

	for index_point in range(nb_points):
		#draw_arc()
		draw_line(points_arc[index_point], points_arc[index_point + 1], color, 6, true)

func _draw():
	var center = Vector2(830, 400)
	var radius = 102
	var angle_from = 0
	var angle_to = 180
	var color = Color(1.0, 0.0, 0.0)
	#draw_arc(center, radius, 0, 90, int(5000), color, 6, true)
	draw_circle_arc(center, radius, angle_from, angle_to, color)
