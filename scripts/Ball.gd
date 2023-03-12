extends Area2D

@export var speed = Vector2(700, 0)
var screen_size
var playerNode
var playerSize
var enemyNode
var enemySize

var playerScoreNode
var enemyScoreNode

var enemyScore
var playerScore

# Called when the node enters the scene tree for the first time.
func _ready():
	screen_size = get_viewport_rect().size
	position.y = screen_size.y / 2
	position.x = screen_size.x / 2
	playerNode = get_tree().get_root().get_node("Main").get_node("Player")
	playerSize = playerNode.get_node("Sprite2D").texture.get_size()
	enemyNode = get_tree().get_root().get_node("Main").get_node("Enemy")
	enemySize = enemyNode.get_node("Sprite2D").texture.get_size()
	var scoreNode = get_tree().get_root().get_node("Main").get_node("Score")
	playerScoreNode = scoreNode.get_node("PlayerScore")
	enemyScoreNode = scoreNode.get_node("EnemyScore")
	
	enemyScore = 0
	playerScore = 0


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	position -= speed.rotated(rotation) * delta

func _on_player_area_shape_entered(area_rid, area, area_shape_index, local_shape_index):
	reflectBall(playerNode.position.y, playerSize)

func _on_enemy_area_shape_entered(area_rid, area, area_shape_index, local_shape_index):
	reflectBall(enemyNode.position.y, enemySize)
	
func reflectBall(paddleY, paddleSize):
	var fromCenter = position.y - paddleY
	var angle = 120 / paddleSize.y * fromCenter
	
	rotation = -rotation
	speed = -speed
	rotation_degrees += angle
	#print("speed: ", speed, " angle: ", rotation_degrees)

func _on_top_bound_area_shape_entered(area_rid, area, area_shape_index, local_shape_index):
	rotation_degrees = -rotation_degrees

func _on_bottom_bound_area_shape_entered(area_rid, area, area_shape_index, local_shape_index):
	rotation_degrees = -rotation_degrees

func _on_player_net_area_shape_exited(area_rid, area, area_shape_index, local_shape_index):
	resetBall()
	enemyScore += 1
	
	if enemyScore < 10:
		enemyScoreNode.text = str("0", enemyScore)
	else:
		enemyScoreNode.text = str(enemyScore)
	
	print("Hit player net")

func _on_enemy_net_area_shape_exited(area_rid, area, area_shape_index, local_shape_index):
	resetBall()
	playerScore += 1
	
	if playerScore < 10:
		playerScoreNode.text = str("0", playerScore)
	else:
		playerScoreNode.text = str(playerScore)
	
	print("Hit enemy net")


func resetBall():
	position.y = screen_size.y / 2
	position.x = screen_size.x / 2
	rotation = -rotation 
	speed = -speed
	rotation_degrees = 0
