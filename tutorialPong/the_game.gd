extends Node2D

var score_p1 = 0
var score_p2 = 0
var score_p3 = 0
var score_p4 = 0

var max_circles = 7
var cur_circles = 2

# reference other notes with $ and then filesystem
@onready var ball = $ball
@onready var label_p1 = $CanvasLayer/Control/Label
@onready var label_p2 = $CanvasLayer/Control/Label2
@onready var label_p3 = $CanvasLayer/Control/Label3
@onready var label_p4 = $CanvasLayer/Control/Label4

func _ready():
	ball.out_of_bounds.connect(_on_ball_out_of_bounds)
	# connect makes it listen for the signal
	# when it receives it, it runs _on_ball_oob
	new_game()
	

func new_game():
	score_p1 = 0
	score_p2 = 0
	score_p3 = 0
	score_p4 = 0
	update_score_display()
	ball.start()
	# because ball was referenced as a variable, you can call its methods

func update_score_display():
	label_p1.text = "Left: " + str(score_p1)
	label_p2.text = "Right: " + str(score_p2)
	label_p3.text = "Bottom: " + str(score_p3)
	label_p4.text = "Top: " + str(score_p4)

	# string concatenation like python
	
func _on_ball_out_of_bounds():
	# if ball was on left, right gets point, nad vice versa
	# nvm now it's like if they fail they get a point
	if(randf() < 0.1):
		if(cur_circles < max_circles):
			cur_circles+= 1
			var copy := ball.duplicate()
			ball.get_parent().add_child(copy)
			copy.scale *= Vector2(1.5,1.5)
	if ball.position.x < get_viewport_rect().size.x / 2:
		score_p1 += 1
		# if it's on the left side
	else:
		# if it's out on the right side
		score_p2 += 1
	if ball.position.y < get_viewport_rect().size.y / 2:
		# if it's out on the top side
		score_p4 += 1
	else:
		score_p3 += 1
		# out on the bottom

	update_score_display()
