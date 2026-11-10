extends Node2D

var score_p1 = 0
var score_p2 = 0

# reference other notes with $ and then filesystem
@onready var ball = $ball
@onready var label_p1 = $CanvasLayer/Control/Label
@onready var label_p2 = $CanvasLayer/Control/Label2

func _ready():
	ball.out_of_bounds.connect(_on_ball_out_of_bounds)
	# connect makes it listen for the signal
	# when it receives it, it runs _on_ball_oob
	new_game()
	

func new_game():
	score_p1 = 0
	score_p2 = 0
	update_score_display()
	ball.start()
	# because ball was referenced as a variable, you can call its methods

func update_score_display():
	label_p1.text = "Left: " + str(score_p1)
	label_p2.text = "Right: " + str(score_p2)
	# string concatenation like python
	
func _on_ball_out_of_bounds():
	# if ball was on left, right gets point, nad vice versa
	if ball.position.x < get_viewport_rect().size.x / 2:
		score_p2 += 1
	else:
		score_p1 += 1
	
	update_score_display()
