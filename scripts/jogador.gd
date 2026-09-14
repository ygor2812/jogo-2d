extends CharacterBody2D

enum PlayerState{
	idle,
	walk,
	jump,
	hurt,
	attack
}
@onready var anim: AnimatedSprite2D= $AnimatedSprite2D
@onready var collision_shape_2d: CollisionShape2D = $CollisionShape2D
@onready var area_golpe: Area2D = $AreaGolpe

const SPEED = 300.0
const JUMP_VELOCITY = -400.0
var jump_count=0
var max_jump_count=2
var status:PlayerState
var direction =0

@export var vida_maxima: int = 5
var vida: int

@export var tempo_hurt: float = 0.4
var tempo_no_hurt: float = 0.0

@export var dano_do_golpe: int = 2
@export var quadro_do_golpe: int = 3
var golpe_aplicado: bool = false

func _ready() -> void:
	vida = vida_maxima
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
		PlayerState.hurt:
			hurt_state()
		PlayerState.attack:
			attack_state()

	move_and_slide()

func go_to_idle_state():
	status= PlayerState.idle
	anim.play("idle")
	anim.modulate = Color(1, 1, 1)
func go_to_walk_state():
	status= PlayerState.walk
	anim.play("walk")
func go_to_jump_state():
	status= PlayerState.jump
	anim.play("jump")
	velocity.y=JUMP_VELOCITY
	jump_count+=1

func go_to_hurt_state() -> void:
	status = PlayerState.hurt
	anim.play("hurt")
	anim.modulate = Color(1, 0.4, 0.4)
	tempo_no_hurt = 0.0
	velocity.x = 0

func hurt_state() -> void:
	tempo_no_hurt += get_physics_process_delta_time()
	if tempo_no_hurt >= tempo_hurt:
		go_to_idle_state()
		return

func go_to_attack_state() -> void:
	status = PlayerState.attack
	anim.play("attack")
	velocity.x = 0
	golpe_aplicado = false
	area_golpe.monitoring = true

func attack_state() -> void:
	if not golpe_aplicado and anim.frame >= quadro_do_golpe:
		golpe_aplicado = true
		for corpo in area_golpe.get_overlapping_bodies():
			if corpo != self and corpo.has_method("levar_dano"):
				corpo.levar_dano(dano_do_golpe)

	if not anim.is_playing():
		area_golpe.monitoring = false
		go_to_idle_state()
		return

func levar_dano(quantidade: int) -> void:
	if status == PlayerState.hurt:
		return
	vida -= quantidade
	print("vida: ", vida)
	if vida <= 0:
		morrer()
		return
	go_to_hurt_state()

func morrer() -> void:
	status = PlayerState.hurt
	anim.play("death")
	velocity.x = 0
	area_golpe.monitoring = false
	set_physics_process(false)

func idle_state():
	move()
	if velocity.x !=0:
		go_to_walk_state()
		return
	if Input.is_action_just_pressed("jump"):
		go_to_jump_state()
		return
	if Input.is_action_just_pressed("attack"):
		go_to_attack_state()
		return

func walk_state():
	move()
	if velocity.x==0:
		go_to_idle_state()
		return
	if Input.is_action_just_pressed("jump"):
		go_to_jump_state()
		return
	if Input.is_action_just_pressed("attack"):
		go_to_attack_state()
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
		area_golpe.position.x = -abs(area_golpe.position.x)
	elif direction>0:
		anim.flip_h=false
		area_golpe.position.x = abs(area_golpe.position.x)
