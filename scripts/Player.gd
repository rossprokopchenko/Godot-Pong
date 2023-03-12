extends Area2D

@export var speed = 500
var screen_size
var playerSize
signal hit

# Called when the node enters the scene tree for the first time.
func _ready():
	screen_size = get_viewport_rect().size
	position.y = screen_size.y / 2
	position.x = 40
	playerSize = $Sprite2D.texture.get_size()


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	var velocity = Vector2.ZERO
	
	if Input.is_action_pressed("move_up"):
		velocity.y -= 1
	if Input.is_action_pressed("move_down"):
		velocity.y += 1
		
	velocity = velocity.normalized() * speed
	position += velocity * delta
	position.y = clamp(position.y, playerSize.y / 2 + 10, screen_size.y - playerSize.y / 2 - 10)
