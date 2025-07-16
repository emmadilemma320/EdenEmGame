extends Node

@export var discovered: Array[String]
@onready var current_scene = $"."
@onready var current_open_menu: Array[String]

signal talk_to(NPC)

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	discovered.append("amanita")
	discovered.append("chom bomb")
	current_open_menu.append("none")
	#chom_bomb.talk_button_pressed.connect(test)
	#connect_signal(frog)
	#frog.talk_button_pressed.connect(test)

func test(npc: NPC):
	#print("talk button of npc ", npc.name," pressed")
	talk_to.emit(npc)

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta: float) -> void:
	pass
	
# copy-paste into code when you wish to use it
func wait(seconds: float) -> void:
	await get_tree().create_timer(seconds).timeout

func connect_signal(npc: NPC):
	npc.talk_button_pressed.connect(test)
