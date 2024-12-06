extends CharacterBody2D


const SPEED = 300.0
const JUMP_VELOCITY = -400.0
var originalPosition = 683
var targetY = 300


@onready var area: Area2D = $ControllableArea
@onready var cooldown: Timer = $Cooldown

func _ready() -> void:
	#area.connect("body_entered", self, "_on_body_entered")
	#area.connect("body_exited", self, "_on_body_exited")
	#area.connect(_on_body_entered)
	area.body_entered.connect(_on_body_entered)
	area.body_exited.connect(_on_body_exited)

func _physics_process(delta: float) -> void:
	## Add the gravity.
	#if not is_on_floor():
		#velocity += get_gravity() * delta
	#if area:
	if (Manager.playerInRange):
		if (Manager.playerInvoke):
			beInvoked()
			Manager.playerInvoke = false
	
		
	## Handle jump.
	#if Input.is_action_just_pressed("ui_accept") and is_on_floor():
		#velocity.y = JUMP_VELOCITY
#
	## Get the input direction and handle the movement/deceleration.
	## As good practice, you should replace UI actions with custom gameplay actions.
	#var direction := Input.get_axis("ui_left", "ui_right")
	#if direction:
		#velocity.x = direction * SPEED
	#else:
		#velocity.x = move_toward(velocity.x, 0, SPEED)

	move_and_slide()


#func _process(delta: float) -> void:
	
	
func _on_body_entered(body: Node) -> void:
	var player = body as Player
	if player:
		Manager.playerInRange = true
		


func _on_body_exited(body: Node) -> void:
	var player = body as Player
	if player:
		Manager.playerInRange = false
	

func beInvoked() -> void :
	if cooldown.time_left:
		return
	velocity.y = move_toward(velocity.y,-1000, 1300)
	cooldown.start()	
	
	
	
