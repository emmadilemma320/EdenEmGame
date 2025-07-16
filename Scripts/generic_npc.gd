extends Area2D

# the resource of the character they represent
@export var character: NPC
var connected = false

#nodes
@onready var nametag: Label = $nametag
@onready var emoter: AnimatedSprite2D = $emoter
@onready var talk_button: TextureButton = $talk_button
@onready var gift_button: TextureButton = $gift_button

signal gifting_npc(NPC)

func _ready():
	name = character.name
	nametag.text = character.name if Global.discovered.has(character.name) else "???"
	gifting_npc.connect(Global.waiting_for_gift)
	
func _process(_delta):
	pass
	

func _on_talk_button_pressed() -> void:
	#if the player has never talked to this npc, add their name to the discovered list
	# and update their nametag
	
	if !Global.discovered.has(character.name):
		Global.discovered.append(character.name)
		nametag.text = character.name
		
	# set values 
	#character.wants_to_talk = false
	talk_button.visible = false
	character.emit_talk_signal()
	
	# play emotes and print message
	emoter.loop("speaking")
	await Global.done_speaking
	emoter.visible = false
	emoter.emote("love")
	
	# once we're done, set the talk button to visible again
	talk_button.visible = true

func gifting() -> void:
	gifting_npc.emit(character)
	var gift: String = await Global.gift_is
	character.receive_gift(gift)

func _on_mouse_entered() -> void:
	nametag.visible = true

func _on_mouse_exited() -> void:
	nametag.visible = false

func _on_body_entered(body: Node2D) -> void:
	if character.wants_to_talk:
		talk_button.visible = true
	if !connected:
		Global.connect_signal(character)
		connected = true

func _on_body_exited(body: Node2D) -> void:
	talk_button.visible = false
