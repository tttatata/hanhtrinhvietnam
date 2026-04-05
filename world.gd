extends Node2D

func _ready() -> void:
	# Code chạy 1 lần duy nhất khi game bắt đầu
	print("Chào mừng phượt thủ đến với thế giới game!")
	
	# Ví dụ: Khóa chuột vào màn hình game hoặc ẩn chuột nếu cần
	# Input.set_mouse_mode(Input.MOUSE_MODE_CAPTURED)

func _process(delta: float) -> void:
	# Code chạy liên tục mỗi khung hình
	# Thường dùng để bắt các phím hệ thống như ESC để mở Menu
	if Input.is_action_just_pressed("ui_cancel"): # Phím ESC
		# get_tree().quit() # Thoát game hoặc mở menu
		pass
