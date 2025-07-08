extends Resource

class_name NPC

# character info
@export var name: String
@export var texture: Texture2D

#player-character info
@export var friendship_points: int
@export var romancable: bool
@export var romance_points: int
@export var relationship_status: String

# character conversation (dictionary of Dialogue resources)
@export var conversations: Dictionary

func _to_string() -> String:
	return  name
	
func change_friendship(points: int):
	friendship_points += points

func change_romance(points: int):
	romance_points += points
