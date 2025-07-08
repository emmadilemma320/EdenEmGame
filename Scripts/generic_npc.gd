extends Area2D

# the resource of the character they represent
@export var character: NPC

#nodes
@onready var nametag: Label = $nametag
@onready var emoter: AnimatedSprite2D = $emoter
@onready var talk_button: TextureButton = $talk_button
#@onready var player = preload("res://Scenes/player.tscn")

func _ready():
	name = character.name
	nametag.text = character.name if Global.discovered.has(character.name) else "???"
	
func _process(_delta):
	pass
	

func _on_talk_button_pressed() -> void:
	#if the player has never talked to this npc, add their name to the discovered list
	# and update their nametag
	if !Global.discovered.has(character.name):
		Global.discovered.append(character.name)
		nametag.text = character.name
		
	# set values 
	character.wants_to_talk = false
	talk_button.visible = false
	Global.player_is_speaking = true
	
	# play emotes and print message
	emoter.emote("speaking")
	print("You have a nice chat")
	emoter.emote("love")
	
	# once we're done, set the talk button to visible again
	talk_button.visible = true
	

func _on_mouse_entered() -> void:
	nametag.visible = true

func _on_mouse_exited() -> void:
	nametag.visible = false
