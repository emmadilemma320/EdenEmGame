extends AnimatedSprite2D

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	visible = false

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
	
func emote(emotion: String):
	visible = true
	play(emotion)
	var animation_time: float = sprite_frames.get_frame_count(emotion) / sprite_frames.get_animation_speed(emotion)
	print("animation ", emotion, " runs at ", sprite_frames.get_animation_speed(emotion), " fps for ", sprite_frames.get_frame_count(emotion), " frames, for a total of ", animation_time, " second(s)")
	await get_tree().create_timer(animation_time).timeout
	visible = false
