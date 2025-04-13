extends Camera2D


func _ready() -> void:
	
	$Camera2D.limit_left = 0
	$Camera2D.limit_right = 10000  # Μεγαλύτερο από τις συντεταγμένες spawn (3196, 2408)
	$Camera2D.limit_top = 0
	$Camera2D.limit_bottom = 10000
	$Camera2D.position_smoothing_enabled = true  # Ομαλή μετακίνηση
	$Camera2D.reset_smoothing()
