extends Resource

class_name Dialogue

@export var npc_replies: Array[ReplyPattern]
@export var player_replies: Array[ReplyPattern]
@export var next_conversation: String


# A Dialogue resource holds three variables:
# - the npc replies, i.e. what the npc says in response to the player, an array of ReplyPattern objects
# - the player replies, i.e. the player can say in response to the npc
# player and npc replies are in the form of ReplyPattern objects
# each ReplyPattern represents one "list" of dialogue for the player/npc to choose from (the player gets input from the player, while the npc depends on what the player says)
# each ReplyPattern also holds a set of point values, represent the change in friendship with the given npc if the player chooses that option
# the point values for the npc's dialogue currently does nothing
# since NPCs always get the last word, they have one more ReplyPattern than the player
# The "next conversation" tells the game which conversation with this npc would happen next via is *key in the npc conversations dictonary*. 
# It is very important that this string match *exactly* with the one used as the key in the dictionary
