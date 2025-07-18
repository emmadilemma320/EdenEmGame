extends Node

@export var discovered_npcs: Array[String]
@export var discovered_collectables: Array[String]
@export var discovered_recipes: Array[String]
@onready var current_scene = $"."
@onready var current_open_menu: Array[String]

@onready var inventory: Inventory = preload("res://Resources/player_inventory.tres")

signal talk_to(NPC)
signal talking
signal done_speaking
signal gift_is(String)
signal get_gift
signal scene_change_signal(String, Vector2)

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	discovered_collectables.append("amanita")
	discovered_npcs.append("chom bomb")
	current_open_menu.append("none")
	
	#chom_bomb.talk_button_pressed.connect(test)
	#connect_signal(frog)
	#frog.talk_button_pressed.connect(test)

func emit_talk_to(npc: NPC):
	#print("talk button of npc ", npc.name," pressed")
	talk_to.emit(npc)
	talking.emit()
	
	
func emit_done_speaking():
	done_speaking.emit()

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta: float) -> void:
	pass
	
# copy-paste into code when you wish to use it
func wait(seconds: float) -> void:
	await get_tree().create_timer(seconds).timeout

func connect_signal(npc: NPC):
	npc.talk_button_pressed.connect(emit_talk_to)
	
func emit_gift_is(gift_i: int):
	var gift: String = inventory.slots[gift_i].item.name
	gift_is.emit(gift)

func waiting_for_gift(npc: NPC):
	get_gift.emit()

func emit_scene_change_signal(next_scene: String, player_position: Vector2):
	print("Global speaking: initiated player teleport to ", next_scene)
	scene_change_signal.emit(next_scene, player_position)
