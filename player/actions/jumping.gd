extends BaseAction

var _timer

func _ready() -> void:
	_timer = Timer.new()
	_timer.one_shot = true
	_timer.connect("timeout", _on_timer_timeout)
	add_child(_timer)

func _on_jumping_state_entered() -> void:
	animation_fsm.travel("Jump_Start")
	start_oneshot_timer(0.25)

func start_oneshot_timer(duration: float) -> void:
	_timer.wait_time = duration
	_timer.start()

func _on_timer_timeout() -> void:
	player.velocity.y = player.jump_speed
