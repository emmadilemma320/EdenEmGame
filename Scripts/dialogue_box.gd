extends Control

var has_dialogue: bool = true
@onready var talk_button: TextureButton = $talk_button

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	if has_dialogue:
		talk_button.visible = true
	else:
		talk_button.visible = false

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass


func _on_talk_button_pressed() -> void:
	print("you had a nice chat!")
