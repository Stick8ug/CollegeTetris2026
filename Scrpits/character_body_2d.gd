extends CharacterBody2D

var moveDirection: Vector2
var inputTimer: float = 0
var inputStrength: int = 0
var isAutoShifting: bool = false
var firstDelayedShift: bool = true
const gridSize: float = 60
const delayedAutoShift: int = 2
const autoShiftRate: int = 1

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	playerMovement(delta)
	pass
	


func horizontalMovement(delta: float):
	
	getMoveDirection()
	inputStrength = Input.get_action_strength("moveRight")
	
	if moveDirection.x != 0:
		
		#The first move is instant
		if firstDelayedShift == true:
			move_local_x(gridSize * moveDirection.x)
			firstDelayedShift = false
			inputTimer = 0
			
		inputTimer += delta
		
		#wait the length of the delayed autoshift and check if we are autoshifting then move
		if (inputTimer >= delayedAutoShift) && (isAutoShifting == false):
			move_local_x(gridSize * moveDirection.x)
			isAutoShifting = true
			inputTimer = 0
		
		#move for every time the autoshift rate = input timer
		if (inputTimer >= autoShiftRate) && (isAutoShifting == true):
			move_local_x(gridSize * moveDirection.x)
			inputTimer = 0
			
	#reset if we have released the button
	if (Input.is_action_just_released("moveRight") || Input.is_action_just_released("moveLeft")):
			firstDelayedShift = true
			isAutoShifting = false
			inputTimer = 0
		
func getMoveDirection():
	moveDirection = Input.get_vector("moveLeft", "moveRight", "moveDown", "moveUp")
		
func playerMovement(delta: float):
	horizontalMovement(delta)
