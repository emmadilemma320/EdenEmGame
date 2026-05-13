extends CharacterBody2D


var current_speed = 300.0
@export var inventory: Inventory

@export var player_name: String = "player"
@onready var generic_collectable = preload("res://Scenes/Items/generic_collectable.tscn")
@onready var emoter: AnimatedSprite2D = $emoter

func _ready():
	inventory.player_drop.connect(drop)

func _physics_process(delta: float) -> void:
	# left & right
	if Input.is_action_pressed("move_left"):
		velocity.x = current_speed*-1 #move left
		$AnimatedSprite2D.play("left_facing_walk")
	elif Input.is_action_pressed("move_right"):
		velocity.x = current_speed #move right
		$AnimatedSprite2D.play("right_facing_walk")
	else:
		velocity.x = move_toward(velocity.x, 0, current_speed)
	
	#up & down
	if Input.is_action_pressed("move_up"):
		velocity.y = current_speed*-1 #move up
		$AnimatedSprite2D.play("back_facing_walk")
	elif Input.is_action_pressed("move_down"):
		velocity.y = current_speed #move down
		$AnimatedSprite2D.play("front_facing_walk")
	else:
		velocity.y = move_toward(velocity.y, 0, current_speed)

	if velocity.length() == 0:
		match ($AnimatedSprite2D.animation):
			"front_facing_walk": 
				$AnimatedSprite2D.play("front_facing_idle")
			"back_facing_walk":
				$AnimatedSprite2D.play("back_facing_idle")
			"left_facing_walk":
				$AnimatedSprite2D.play("left_facing_idle")
			"right_facing_walk":
				$AnimatedSprite2D.play("right_facing_idle")
	
	move_and_slide()

func collect(item, num) -> int:
	var num_left = inventory.insert(item, num)
	if num_left == 0:
		if !Global.discovered_collectables.has(item.name):
			Global.discovered_collectables.append(item.name)
	return num_left

func drop(slot, amt: int):
	var dropped_collectable = generic_collectable.instantiate()
	dropped_collectable.inventory_self = slot.item
	dropped_collectable.amount = amt
	dropped_collectable.position = self.position
	self.get_parent().add_child(dropped_collectable)
