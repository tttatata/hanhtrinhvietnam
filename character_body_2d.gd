extends CharacterBody2D

# Thiết lập tốc độ theo phong cách phượt thủ hiện đại [cite: 54]
@export var walk_speed = 150.0
@export var run_speed = 300.0 

@onready var _animated_sprite = $AnimatedSprite2D

func _physics_process(_delta):
	# 1. Lấy hướng di chuyển (Top-down) [cite: 119]
	var direction = Input.get_vector("ui_left", "ui_right", "ui_up", "ui_down")
	
	# 2. Kiểm tra xem người chơi có đang giữ nút chạy không
	var is_running = Input.is_action_pressed("run")
	var current_speed = run_speed if is_running else walk_speed

	# 3. Xử lý di chuyển và Hoạt ảnh (Animation)
	if direction != Vector2.ZERO:
		velocity = direction * current_speed
		
		# Chuyển đổi giữa 6 ảnh chạy hoặc 8 ảnh đi bộ
		if is_running:
			_animated_sprite.play("run")
		else:
			_animated_sprite.play("walk")
			
		# Lật hình ảnh khi phượt thủ đổi hướng trái/phải [cite: 60]
		if direction.x != 0:
			_animated_sprite.flip_h = direction.x < 0
	else:
		# Trạng thái đứng yên (Sử dụng 4 ảnh idle)
		velocity = velocity.move_toward(Vector2.ZERO, current_speed)
		_animated_sprite.play("idle")

	move_and_slide()
