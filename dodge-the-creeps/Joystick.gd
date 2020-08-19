extends TouchScreenButton

var size = Vector2(250,250)
var center = position + (size / 2)
var axis_x = 0
var axis_y = 0
var emit = false
var tpressed = false
var boundary = 500

func _ready():
	size *= scale
	boundary = size * 2
	center = position + (size / 2)
	set_initial_analog()

func hide():
	.hide()
	axis_x = 0
	axis_y = 0
	set_initial_analog()

var count = 1
func _input(event):
	if (event is InputEventScreenDrag or (event is InputEventScreenTouch and event.is_pressed())):
		if (compare_vector_axis(event.position, position) and compare_vector_axis(event.position, position + size, "lte")):
			$Analog.show()
			tpressed = true
		if tpressed == true:
			var analog = ((event.position - position)*1.1) + (size/2)
			$Analog.position.x = clamp(analog.x, 0, boundary.x)
			$Analog.position.y = clamp(analog.y, 0, boundary.y)
			emit = true
			axis_x = (1 if (event.position.y < center.y) else -1)
			axis_y = (1 if (event.position.x > center.x) else -1)
	elif event is InputEventScreenTouch and emit == true:
		emit = false
		axis_x = 0
		axis_y = 0
		$Analog.position = size
		$Analog.hide()

func compare_vector_axis(one, two, expression = "gte"):
	var result = false
	if "gt" in expression:
		result = one.x > two.x and one.y > two.y
	elif "lt" in expression:
		result = one.x < two.x and one.y < two.y
	if "e" in expression and result:
		result = result or (one.x == two.x and one.y == two.y)
	return result

func get_direction():
	return Vector2(axis_x, axis_y)

func set_initial_analog():
	$Analog.scale = scale
	$Analog.position = size
	$Analog.hide()
	

