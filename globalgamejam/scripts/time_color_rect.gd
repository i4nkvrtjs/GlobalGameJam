extends ColorRect

func set_time_color(color: Color, strength := 0.25):
	visible = true
	self.color = Color(
		color.r,
		color.g,
		color.b,
		strength
	)

func clear():
	visible = false
