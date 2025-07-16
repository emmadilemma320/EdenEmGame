extends AnimatedSprite2D

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	visible = false

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
	
func emote(emotion: String):
	var animation_time: float
	#if the emote is not a valid one, it prints an error and exits the method
	if !sprite_frames.has_animation(emotion):
		print("emotion not found!")
		return
	
	#while it is visible that means another emote is already playing, 
	# so we wait for it to finsh playing
	while visible and !(animation == emotion):
		#print("animation ", animation, " is already playing!")
		animation_time = sprite_frames.get_frame_count(animation) / sprite_frames.get_animation_speed(animation)
		await get_tree().create_timer(animation_time).timeout
	
	#calculate the time the given emote will take
	animation_time = sprite_frames.get_frame_count(emotion) / sprite_frames.get_animation_speed(emotion)
	
	#set self to visible and play the emote, then wait until it's done
	visible = true
	play(emotion)
	await get_tree().create_timer(animation_time).timeout
	visible = false
	
func loop(emotion):
	var animation_time
	if !sprite_frames.has_animation(emotion):
		print("emotion not found!")
		return
		
	while visible and !(animation == emotion):
		#print("animation ", animation, " is already playing!")
		animation_time = sprite_frames.get_frame_count(animation) / sprite_frames.get_animation_speed(animation)
		await get_tree().create_timer(animation_time).timeout
		
	visible = true
	play(emotion)
	
