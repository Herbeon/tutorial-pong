extends CharacterBody2D


@export var speed = 500
@export var left_action = "p3_left"
@export var right_action = "p3_right"

@onready var animated_sprite = $AnimatedSprite2D

# export var allows them to be seen in the editor
# and means you can instantiate multiple
# and can change the values

func _ready():
	animated_sprite.play("default")

	add_to_group("paddles")

func _physics_process(delta):
	var direction = 0
	if Input.is_action_pressed(left_action):
		direction = -1 
	elif Input.is_action_pressed(right_action):
		direction = 1 # goes down
		
	velocity.x = direction * speed
	move_and_collide(Vector2(velocity.x * delta,0))
	#y value does not change
	
	var screen_size = get_viewport_rect().size
	var paddle_height = 108
	position.y = clamp(position.y, paddle_height / 2, screen_size.y - (paddle_height / 2))
	# doesn't let it go offscreen
	# can also achieve with a border with collision
