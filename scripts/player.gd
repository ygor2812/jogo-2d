extends CharacterBody2D

enum PlayerState{
	idle,
	walk,
	jump,
	crouching
}
@onready var anim: AnimatedSprite2D= $AnimatedSprite2D
@onready var collision_shape_2d: CollisionShape2D = $CollisionShape2D

const SPEED = 300.0
const JUMP_VELOCITY = -400.0
var jump_count=0
var max_jump_count=2
var status:PlayerState
var direction =0
func _ready() -> void:
	go_to_idle_state()
	
func _physics_process(delta:float)-> void:
	if not is_on_floor():
		velocity += get_gravity() * delta
	match status :
		PlayerState.idle:
			idle_state()
		PlayerState.walk:
			walk_state()
		PlayerState.jump:
			jump_state()
		PlayerState.crouching:
			crouching_state()
			
	move_and_slide()
func go_to_idle_state():
	status= PlayerState.idle
	anim.play("idle")
func go_to_walk_state():
	status= PlayerState.walk
	anim.play("walk")
func go_to_jump_state():
	status= PlayerState.jump
	anim.play("jump")
	velocity.y=JUMP_VELOCITY
	jump_count+=1
func go_to_crouching_state():
	status=PlayerState.crouching
	anim.play("crouching")
	collision_shape_2d.shape.radius=3
	collision_shape_2d.shape.height=6
	collision_shape_2d.position.y=5
	collision_shape_2d.position.x=2
func exit_from_crouching_state():
	collision_shape_2d.shape.radius=4
	collision_shape_2d.shape.height=10
	collision_shape_2d.position.y=3
	collision_shape_2d.position.x=2
func idle_state():
	move()
	if velocity.x !=0:
		go_to_walk_state()
		return
	if Input.is_action_just_pressed("jump"):
		go_to_jump_state()
		return
		
	if Input.is_action_pressed("crouching"):
		go_to_crouching_state()
		return
		
func walk_state():
	move()
	if velocity.x==0:
		go_to_idle_state()
		return
	if Input.is_action_just_pressed("jump"):
		go_to_jump_state()
		return
func jump_state():
	move()
	if Input.is_action_just_pressed("jump")&&jump_count<max_jump_count:
		go_to_jump_state()
	
	if is_on_floor():
		jump_count=0 
		if velocity.x ==0:
			go_to_idle_state()
		else:
			go_to_walk_state()
		return
func crouching_state():
	update_direction()
	if Input.is_action_just_released("crouching"):
		exit_from_crouching_state()
		go_to_idle_state()
		return

func move():
	update_direction()
	if direction:
		velocity.x = direction * SPEED
	else:
		velocity.x = move_toward(velocity.x, 0, SPEED)

func update_direction():
	direction = Input.get_axis("ui_left", "ui_right")
	if direction<0:
		anim.flip_h = true
	elif direction>0:
			anim.flip_h=false
	
