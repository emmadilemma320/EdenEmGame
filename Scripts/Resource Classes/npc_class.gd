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
@export var relationship_status: String
@export var wants_to_talk: bool

# character conversation (dictionary of Dialogue resources)
@export var conversations: Dictionary

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
