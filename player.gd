extends CharacterBody2D

# 1. Thông số di chuyển (Có thể chỉnh trong Inspector)
@export var speed_walk: float = 150.0
@export var speed_run: float = 300.0

# 2. Lấy các Node bằng cách tham chiếu chính xác
@onready var _animated_sprite = $AnimatedSprite2D

func _physics_process(_delta: float) -> void:
	# A. Lấy hướng di chuyển từ phím mũi tên hoặc WASD
	var direction := Input.get_vector("ui_left", "ui_right", "ui_up", "ui_down")
	
	# B. Kiểm tra nếu đang giữ Shift để chạy
	var is_running = Input.is_action_pressed("run") # Bạn nhớ vào Project Settings -> Input Map tạo hành động "run" là phím Shift
	var current_speed = speed_run if is_running else speed_walk
	
	# C. Áp dụng vận tốc di chuyển
	velocity = direction * current_speed
	
	# D. Xử lý logic Hoạt ảnh (Animation)
	if direction != Vector2.ZERO:
		# Xác định tiền tố: 'run_' hoặc 'walk_'
		var action_prefix = "run_" if is_running else "walk_"
		
		if direction.y > 0:
			_animated_sprite.play(action_prefix + "south") # Đi xuống (Mặt)
		elif direction.y < 0:
			_animated_sprite.play(action_prefix + "north") # Đi lên (Lưng)
		elif direction.x != 0:
			_animated_sprite.play(action_prefix + "east")  # Đi ngang
			# Tự động lật hình nếu đi sang trái (West)
			_animated_sprite.flip_h = direction.x < 0
	else:
		# Khi đứng yên: Dựa vào hướng cuối cùng để chọn idle phù hợp
		if _animated_sprite.animation.contains("north"):
			_animated_sprite.play("idle_north")
		else:
			_animated_sprite.play("idle_south")
			
	# E. Thực hiện di chuyển vật lý
	move_and_slide()
