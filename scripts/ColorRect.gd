extends ColorRect

@onready var animator: AnimationPlayer = $AnimationPlayer
@onready var play_button: Button = find_child("ResumeButton")
@onready var quit_button: Button = find_child("QuitButton")

func unpause():
	animator.play("PauseAnimation")
	get_tree().paused = false
	# mouse command only neccesary for 3D
	Input.set_mouse_mode(Input.MOUSE_MODE_CAPTURED)

func pause():
	animator.play("PauseAnimation_2")
	get_tree().paused = true
	# mouse command only neccesary for 3D
	Input.set_mouse_mode(Input.MOUSE_MODE_VISIBLE)
	
# Called when the node enters the scene tree for the first time.
func _ready():
	play_button.pressed.connect(unpause)
	quit_button.pressed.connect(get_tree().quit)


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass
