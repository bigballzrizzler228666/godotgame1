extends CharacterBody2D

const SPEED = 120.0
const JUMP_VELOCITY = -300.0

# =========================
# STATE
# =========================
var is_dashing = false
var dash_unlocked = false

var dash_timer = 0.0
var dash_duration = 0.55
var dash_speed = 200.0
var dash_direction = 1

var is_hit = false
var gravity_lock = false
var animation_locked = false

# =========================
# HP
# =========================
var max_hp := 3
var hp := 3

# =========================
# JUMP
# =========================
var max_jumps = 2
var jumps_used = 0

# =========================
# SUPER DASH
# =========================
var super_dash_unlocked = false
var is_super_dashing = false
var charging_super_dash = false

var super_dash_charge = 0.0
var super_dash_required = 2.0   # you said 2 seconds now

var super_dash_dir = 1
var super_dash_speed = 320

# charge multiplier (faster filling feel)
var super_dash_charge_speed = 1.6

# =========================
# NODES
# =========================
@onready var animated_sprite: AnimatedSprite2D = $AnimatedSprite2D

@onready var super_dash_ui = get_node_or_null("../CanvasLayer/SuperDashUI")
@onready var super_dash_bar = get_node_or_null("../CanvasLayer/SuperDashUI/SuperDashBar")
@onready var super_dash_label = get_node_or_null("../CanvasLayer/SuperDashUI/Label")


func _ready():
	if super_dash_ui:
		super_dash_ui.visible = true


func _physics_process(delta: float) -> void:

	update_super_dash_ui()

	var direction := Input.get_axis("move_left", "move_right")

	# =========================
	# SUPER DASH CHARGE
	# =========================
	if super_dash_unlocked and !is_super_dashing:

		if Input.is_action_pressed("superdash"):
			charging_super_dash = true
			super_dash_charge = min(
				super_dash_charge + delta * super_dash_charge_speed,
				super_dash_required
			)

		elif charging_super_dash:
			if super_dash_charge >= super_dash_required:
				start_super_dash()
			else:
				super_dash_charge = 0.0

			charging_super_dash = false


	# =========================
	# SUPER DASH MOVEMENT
	# =========================
	if is_super_dashing:
		velocity.x = super_dash_speed * super_dash_dir
		velocity.y = 0

		if is_on_wall():
			stop_super_dash()

		move_and_slide()
		return


	# =========================
	# NORMAL DASH INPUT
	# =========================
	if dash_unlocked and Input.is_action_just_pressed("dash") and !is_dashing:
		start_dash()

	if is_dashing:
		dash_timer -= delta
		velocity.x = dash_speed * dash_direction
		velocity.y = 0

		if dash_timer <= 0:
			stop_dash()

		move_and_slide()
		return


	# =========================
	# GRAVITY
	# =========================
	if !is_on_floor() and !gravity_lock:
		velocity += get_gravity() * delta


	# =========================
	# JUMP (EXACT 2 JUMPS MAX)
	# =========================
	if is_on_floor():
		jumps_used = 0

	if Input.is_action_just_pressed("jump"):
		if jumps_used < max_jumps:
			velocity.y = JUMP_VELOCITY
			jumps_used += 1


	# =========================
	# MOVE
	# =========================
	if !is_dashing and !is_hit:
		if direction != 0:
			velocity.x = direction * SPEED
		else:
			velocity.x = move_toward(velocity.x, 0, SPEED)


	# =========================
	# FLIP
	# =========================
	if direction != 0:
		animated_sprite.flip_h = direction < 0


	# =========================
	# ANIMATION
	# =========================
	if !animation_locked and !is_hit:
		if is_on_floor():
			if direction == 0:
				animated_sprite.play("idle")
			else:
				animated_sprite.play("run")
		else:
			animated_sprite.play("jump")


	move_and_slide()


# =========================
# DASH
# =========================
func start_dash():

	is_dashing = true
	dash_timer = dash_duration

	dash_direction = -1 if animated_sprite.flip_h else 1

	gravity_lock = true
	animation_locked = true

	animated_sprite.play("roll")


func stop_dash():

	is_dashing = false
	gravity_lock = false
	animation_locked = false


# =========================
# SUPER DASH
# =========================
func start_super_dash():

	if super_dash_charge < super_dash_required:
		return

	is_super_dashing = true
	super_dash_dir = -1 if animated_sprite.flip_h else 1

	gravity_lock = true
	animation_locked = true

	animated_sprite.play("roll")


func stop_super_dash():

	is_super_dashing = false
	gravity_lock = false
	animation_locked = false

	super_dash_charge = 0.0
	charging_super_dash = false


# =========================
# UNLOCKS (POTIONS)
# =========================
func unlock_double_jump():
	max_jumps = 2


func unlock_dash():
	dash_unlocked = true


func unlock_super_dash():
	super_dash_unlocked = true


# =========================
# UI UPDATE
# =========================
func update_super_dash_ui():

	if !super_dash_ui:
		return

	super_dash_ui.visible = super_dash_unlocked

	if !super_dash_bar:
		return

	super_dash_bar.min_value = 0
	super_dash_bar.max_value = 1
	super_dash_bar.value = super_dash_charge / super_dash_required


func _on_shop_door_body_entered(body: Node2D) -> void:
	pass # Replace with function body.
