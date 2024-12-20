extends CharacterBody2D


var fall_velocity = 150.0
var gravity = 300
var state = false
@onready var random_value: int = 50
@onready var kill_enemy_sound: AudioStreamPlayer = $Kill_enemy_sound
@onready var floorDetector: RayCast2D = $RayCast2D


var target: Player
@onready var detection_area: Area2D = $DetectionArea

func _ready() -> void:
	detection_area.body_entered.connect(_on_detection_body_entered)
	detection_area.body_exited.connect(_on_detection_body_exited)
	

func _physics_process(delta: float) -> void:
	# Add the gravity.
	if floorDetector.is_colliding():
		queue_free()
	

	#if (not target) and (not is_on_ceiling())
	if (not target):
		velocity.y = move_toward(velocity.y,-1*fall_velocity, 0)
		#var direction = pivot.scale.x
		#velocity.x = move_toward(velocity.x, direction * speed, acceleration * delt
	elif target:
		_random_way()
		velocity.y = move_toward(velocity.y, gravity+random_value, 4000)
		#var direction = global_position.direction_to(target.global_position)
		#velocity.x = move_toward(velocity.x, direction.x * speed, acceleration * delta)
	# Handle jump.

	# Get the input direction and handle the movement/deceleration.
	# As good practice, you should replace UI actions with custom gameplay actions.

	move_and_collide(delta*velocity)
	

func _random_way(max: int = 350, min: int = -70) -> void:
	if state == false:
		return
	else:
		var value = randi() % (max-min+1) + min
		random_value += value
	
func _on_detection_body_entered(body: Node) -> void:
	var player = body as Player
	if player:
		target = player
		state = true
		

func _on_detection_body_exited(body: Node) -> void:
	if body == target:
		target = null
		state= false
		

func take_damage(damage: int):
	kill_enemy_sound.play()
	queue_free()
