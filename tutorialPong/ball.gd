extends CharacterBody2D

signal out_of_bounds
# can send

@export var speed = 300

func start():
	position = get_viewport_rect().size / 2
	
	var direction_x = 1.0 if randf() > 0.5 else -1.0
	# yay gambling
	
	var direction_y = randf_range(-0.5,0.5)
	# yay more gambling
	
	velocity = Vector2(direction_x,direction_y).normalized() * speed
	# normalized makes the vector an integer (pythagorean theorem it)
func _ready():
	start()
	# that way start() can be called to reset ball during game too

func _physics_process(delta):
	if position.x < 0 or position.x > get_viewport_rect().size.x:
		# left/right
		out_of_bounds.emit() # signalname.emit() sends a signal
		start()
	
	if position.y < 0 or position.y > get_viewport_rect().size.y:
		out_of_bounds.emit()
		start() 

	var collision = move_and_collide(velocity * delta)
	# move and collide returns a boolean if it hits something
	if collision:
		velocity = velocity.bounce(collision.get_normal())
		# bounce reflects the thing for us
		var thing_we_hit = collision.get_collider()
		#print(thing_we_hit)
		# if it hit a paddle, speed it up
		if thing_we_hit.is_in_group("paddles"):
			velocity *= 1.1 # 10% inc
