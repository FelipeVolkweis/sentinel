extends BaseAction

var _timer


func _ready() -> void:
	_timer = Timer.new()
	_timer.one_shot = true
	_timer.connect("timeout", _on_timer_timeout)
	add_child(_timer)


func _on_jumping_state_entered() -> void:
	animator.animate("jump_start")
	start_oneshot_timer(0.1)


func start_oneshot_timer(duration: float) -> void:
	_timer.wait_time = duration
	_timer.start()


func _on_timer_timeout() -> void:
	player.jump()
	
