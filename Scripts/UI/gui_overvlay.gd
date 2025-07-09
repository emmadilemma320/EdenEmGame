extends Control

@onready var grimoire_button_base: ColorRect = $grimoire_button_background

@onready var grimoire_base: ColorRect = $grimoire_base
var grimoire_open: bool

@onready var dialogue_base: ColorRect = $dialogue_base
var dialogue_open: bool

@onready var test_dialogue: Dialogue = preload("res://Resources/NPCs/dialogues/chom_bomb/introduction.tres")

# dialogue inner workings
@onready var npc_dialogue: Label = $dialogue_base/dialogue_base/dialogue_background/npc_dialogue
@onready var player_responses_box: VBoxContainer = $dialogue_base/dialogue_base/dialogue_background/player_responses
@onready var player_responses_buttons: Array
signal option_chosen(int)

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	close_grimoire()
	close_dialogue()
	player_responses_buttons = player_responses_box.get_children()


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	# closing current ui menu via "close_current_menu"
	if Input.is_action_just_pressed("close_current_menu"):
		if Global.current_open_menu.back() == grimoire_base.name and grimoire_open:
			close_grimoire()
		if Global.current_open_menu.back() == dialogue_base.name and dialogue_open:
			close_dialogue()
	
	# opening & closing grimoire via "access_grimoire"
	if Input.is_action_just_pressed("access_grimoire"):
		if grimoire_open:
			close_grimoire()
		else:
			open_grimoire()
			
	if Global.player_is_speaking and !dialogue_open:
		open_dialogue()
		
	if Input.is_action_just_pressed("dialogue_option_1"):
		option_chosen.emit(0)
		
	if Input.is_action_just_pressed("dialogue_option_2"):
		option_chosen.emit(1)
		
	if Input.is_action_just_pressed("dialogue_option_3"):
		option_chosen.emit(2)
		
	if Input.is_action_just_pressed("dialogue_option_4"):
		option_chosen.emit(3)
	


func _on_button_pressed() -> void: # grimoire opening button
	if grimoire_open:
		close_grimoire()
	else:
		open_grimoire()

func open_grimoire():
	grimoire_base.visible = true
	grimoire_open = true
	Global.current_open_menu.append(grimoire_base.name)
	
func close_grimoire():
	grimoire_base.visible = false
	grimoire_open = false
	Global.current_open_menu.erase(grimoire_base.name)
	
func open_dialogue():
	npc_dialogue.visible = true
	player_responses_box.visible = false
	dialogue_base.visible = true
	dialogue_open = true
	grimoire_button_base.visible = false
	Global.current_open_menu.append(dialogue_base.name)
	run_dialogue(test_dialogue)
	
func close_dialogue():
	Global.player_is_speaking = false # replace with send a signal
	dialogue_base.visible = false
	dialogue_open = false
	grimoire_button_base.visible = true
	Global.current_open_menu.erase(dialogue_base.name)
	
func run_dialogue(dialogue: Dialogue):
	# method variables & constants
	const scroll_chunks: float = 200.0
	const scroll_speed: float = 0.01
	const reading_buffer: float = 2.0
	
	var current_replies: ReplyPattern
	
	npc_dialogue.visible_ratio = 0.0
	npc_dialogue.visible = true
	player_responses_box.visible = false 
	for i in range(dialogue.npc_replies.size() - 1):
		# first, the npc talks, so we set their box to true and the players to false
		# we scroll through the text and give the player time to read it
		npc_dialogue.text = dialogue.npc_replies[i]
		
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
			close_dialogue()
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
		player_responses_box.visible = true
		
		# we wait for the pick an option and save what they choose, 
		#changing the relationship by any point totals gained/lost
		var option = await option_chosen
		dialogue.npc.change_friendship(current_replies.point_values[option])
		
		# testing prints
		print("you chose ", current_replies.quotes[option])
		print("relationship changed by ", current_replies.point_values[option])
		print("your new relationship is ", dialogue.npc.get_friendship_status(), " with a score of ", dialogue.npc.friendship_points)
		
		#since we're done, we turn the buttons off again, and it goes back to the npc talking  
		for extra_button in range(player_responses_buttons.size()):
			player_responses_buttons[extra_button].visible = false
		
	# npcs always get the last word 
	npc_dialogue.text = dialogue.npc_replies[-1]
		
		# using the visible ratio, slowly increasing it from 0 to 1
	for r in range(scroll_chunks):
		npc_dialogue.visible_ratio = float(r) / scroll_chunks
		await get_tree().create_timer(scroll_speed).timeout
	npc_dialogue.visible_ratio = 1
	
	# once the conversation has ended we close the dialogue
	await get_tree().create_timer(reading_buffer).timeout
	close_dialogue()
	



func _on_option_a_pressed() -> void:
	option_chosen.emit(0)

func _on_option_b_pressed() -> void:
	option_chosen.emit(1)

func _on_option_c_pressed() -> void:
	option_chosen.emit(2)

func _on_option_d_pressed() -> void:
	option_chosen.emit(3)
