extends Area2D

@export var speed = 500

var ballPosition
var ballNode
var screen_size
var enemySize

# Called when the node enters the scene tree for the first time.
func _ready():
	ballNode = get_tree().get_root().get_node("Main").get_node("Ball")
	#print(ballNode)
	screen_size = get_viewport_rect().size
	enemySize = $Sprite2D.texture.get_size()


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	var velocity = Vector2.ZERO
	
	if ballNode.position.x > screen_size.x / 2:
		
		if position.y < ballNode.position.y:
			velocity.y += 1
		else:
			velocity.y -= 1
	
	velocity = velocity.normalized() * speed
	position += velocity * delta
	
	position.y = clamp(position.y, enemySize.y / 2 + 10, screen_size.y - enemySize.y / 2 - 10)
	position.x = clamp(position.x, 1200, 1200)
