extends Resource

class_name NPC

# character info
@export var name: String
@export var portrait: Texture2D

# gifting info
@export var favorite_gift: String
@export var liked_gifts: Array[String]
@export var disliked_gifts: Array[String]

#relationship info
@export var friendship_points: int
@export var romancable: bool
@export var romance_points: int
@export var wants_to_talk: bool

# character conversation (dictionary of Dialogue resources)
@export var conversations: Dictionary
@export var next_conversation: String = "intro"

# CONSTANT relationship status and poits
const FRIENDSHIP_STATUS_NAMES = ["enemies", "acquentiences", "friends"]
const FRIENDSHIP_STATUS_THRESHOLDS = [-10, 10]
const POINTS_FOR_FAV_GIFT = 15
const POINTS_FOR_LIKED_GIFT = 10
const POINTS_FOR_NEUTRAL_GIFT = 5
const POINTS_FOR_DISLIKED_GIFT = -3

signal talk_button_pressed(NPC)


func _to_string() -> String:
	return  name
	
func change_friendship(points: int):
	friendship_points += points

func change_romance(points: int):
	romance_points += points
	
func gift(item: String):
	if item == favorite_gift:
		friendship_points += 10
	elif liked_gifts.has(item):
		friendship_points += 5
	elif disliked_gifts.has(item):
		friendship_points -= 5
		
func get_friendship_status() -> String:
	if friendship_points < FRIENDSHIP_STATUS_THRESHOLDS[0]:
		return FRIENDSHIP_STATUS_NAMES[0]
	
	for i in range(FRIENDSHIP_STATUS_THRESHOLDS.size() - 1):
		if friendship_points >= FRIENDSHIP_STATUS_THRESHOLDS[i] and friendship_points < FRIENDSHIP_STATUS_THRESHOLDS[i+1]:
			return FRIENDSHIP_STATUS_NAMES[i+1]
			
	if friendship_points >= (FRIENDSHIP_STATUS_THRESHOLDS[-1]):
		return FRIENDSHIP_STATUS_NAMES[-1]
	return "unknown friendship status"

func emit_talk_signal():
	talk_button_pressed.emit(self)
	
func receive_gift(gift: String):
	var temp = friendship_points
	if gift == favorite_gift:
		friendship_points += POINTS_FOR_FAV_GIFT
	elif liked_gifts.has(gift):
		friendship_points += POINTS_FOR_LIKED_GIFT
	elif disliked_gifts.has(gift):
		friendship_points += POINTS_FOR_DISLIKED_GIFT
	else:
		friendship_points += POINTS_FOR_NEUTRAL_GIFT
	print("gave gift ", gift, " friendship points increased by ", (friendship_points - temp))
