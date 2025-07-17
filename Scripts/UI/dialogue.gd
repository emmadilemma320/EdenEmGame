extends Control

# speech boxes / buttons
@onready var npc_dialogue: Label = $dialogue_base/dialogue_base/dialogue_background/npc_dialogue
@onready var player_responses_box: VBoxContainer = $dialogue_base/dialogue_base/dialogue_background/player_responses
@onready var player_responses_buttons: Array

# npc views
@onready var npc_portrait: TextureRect = $dialogue_base/npc_base/npc_portrait_background/CenterContainer/npc_portrait
@onready var npc_name: Label = $dialogue_base/npc_base/nameplate/npc_name

#signals
signal option_chosen(int)
signal dialogue_ended

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	# first we set our arrays
	player_responses_buttons = player_responses_box.get_children()
	
	# next we connect our signals
	Global.talk_to.connect(open)
	dialogue_ended.connect(Global.emit_done_speaking)
	
	# next we make sure the menu is closed at the start
	if Global.current_open_menu.has(name):
		Global.current_open_menu.erase(name)
	visible = false


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if Input.is_action_just_pressed("dialogue_option_1"):
		option_chosen.emit(0)
		
	if Input.is_action_just_pressed("dialogue_option_2"):
		option_chosen.emit(1)
		
	if Input.is_action_just_pressed("dialogue_option_3"):
		option_chosen.emit(2)
		
	if Input.is_action_just_pressed("dialogue_option_4"):
		option_chosen.emit(3)

func open(speaking_with: NPC):
	npc_name.text = speaking_with.name
	npc_portrait.texture = speaking_with.portrait
	
	npc_dialogue.visible = true
	npc_dialogue.visible_ratio = 0.0
	
	for j in range(player_responses_buttons.size()):
			player_responses_buttons[j].visible = false
	player_responses_box.visible = true
	
	visible = true
	
	var dialogue: Dialogue = speaking_with.conversations[speaking_with.next_conversation]
	run_dialogue(dialogue, speaking_with)
	
func close():
	visible = false
	dialogue_ended.emit()
	
# see the Dialogue class for a specific definition of its content
func run_dialogue(dialogue: Dialogue, speaking_with: NPC):
	# method variables & constants
	const scroll_chunks: float = 100.0 # higher = slower
	const scroll_speed: float = 0.01 # higher = faster
	const reading_buffer: float = 2.0
	
	var current_replies: ReplyPattern
	var option: int = 0	
	
	for i in range(dialogue.npc_replies.size() - 1):
		# first, the npc talks, so we set their box to true and the players to false
		# we scroll through the text and give the player time to read it
		if dialogue.npc_replies[i].quotes.size() != 1:
			npc_dialogue.text = dialogue.npc_replies[i].quotes[option]
		else:
			npc_dialogue.text = dialogue.npc_replies[i].quotes[0]
		
		# using the visible ratio, slowly increasing it from 0 to 1
		for r in range(scroll_chunks):
			npc_dialogue.visible_ratio = float(r) / scroll_chunks
			await get_tree().create_timer(scroll_speed).timeout
		npc_dialogue.visible_ratio = 1
		
		# give the player some time to read what the npc said
		await get_tree().create_timer(reading_buffer).timeout
		
		# now we switch to the player talking
		# load in the current replies, and check the size of the button box compared to the current replies
		current_replies = dialogue.player_replies[i]
			
		
		#if there are too many replies, an error has occured
		if player_responses_buttons.size() < current_replies.quotes.size():
			print("error occured: more dialogue options that dialogue buttons")
			close()
			return
		
		# if there are too many buttons, we simply turn the extra ones in visible
		if player_responses_buttons.size() > current_replies.quotes.size():
			for extra_button in range(current_replies.quotes.size(), player_responses_buttons.size()):
				player_responses_buttons[extra_button].visible = false
		
		# now we set the text of the buttons equal to each text options the player has
		for j in range(current_replies.quotes.size()):
			player_responses_buttons[j].text = current_replies.quotes[j]
		
		#now that our buttons are ready, we set them to visible and the npc text to invisible
		npc_dialogue.visible_ratio = 0.0
		for j in range(current_replies.quotes.size()):
			player_responses_buttons[j].visible = true
		
		# we wait for the pick an option and save what they choose, 
		#changing the relationship by any point totals gained/lost
		option = await option_chosen
		var prev_relationship = speaking_with.get_friendship_status()
		speaking_with.change_friendship(current_replies.point_values[option])
		if prev_relationship != speaking_with.get_friendship_status():
			print("Your relationship with ", speaking_with.name, " has changed from ", prev_relationship, " to ", speaking_with.get_friendship_status())
		
		#since we're done, we turn the buttons off again, and it goes back to the npc talking  
		for j in range(player_responses_buttons.size()):
			player_responses_buttons[j].visible = false
		
	# npcs always get the last word 
	if dialogue.npc_replies[-1].quotes.size() != 1:
		npc_dialogue.text = dialogue.npc_replies[-1].quotes[option]
	else:
		npc_dialogue.text = dialogue.npc_replies[-1].quotes[0]
	
	for r in range(scroll_chunks):
		npc_dialogue.visible_ratio = float(r) / scroll_chunks
		await get_tree().create_timer(scroll_speed).timeout
	npc_dialogue.visible_ratio = 1
	
	speaking_with.next_conversation = dialogue.next_conversation
	# once the conversation has ended we close the dialogue after giving the player time to read
	await get_tree().create_timer(reading_buffer).timeout
	close()
	
func _on_option_a_pressed() -> void:
	option_chosen.emit(0)

func _on_option_b_pressed() -> void:
	option_chosen.emit(1)

func _on_option_c_pressed() -> void:
	option_chosen.emit(2)

func _on_option_d_pressed() -> void:
	option_chosen.emit(3)
