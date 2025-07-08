extends Area2D

# the resource of the character they represent
@export var character: NPC

#nodes
@onready var nametag: Label = $nametag
@onready var emoter: AnimatedSprite2D = $emoter
#@onready var player = preload("res://Scenes/player.tscn")

func _ready():
	name = character.name
	nametag.text = character.name if Global.discovered.has(character.name) else "???"

func _on_talk_button_pressed() -> void:
	print("You have a nice chat")
	emoter.emote("love")
	if !Global.discovered.has(character.name):
		Global.discovered.append(character.name)
		nametag.text = character.name

func _on_mouse_entered() -> void:
	nametag.visible = true


func _on_mouse_exited() -> void:
	nametag.visible = false
