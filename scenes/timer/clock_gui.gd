extends Control


@onready var time_label: Label = $TimeLabel
@onready var day_label: Label = $DayLabel


func set_daytime(day:int, hour:int, minute:int) -> void:
	time_label.text = _amfm_hour(hour) + ":" + "00 " + _am_pm(hour)
	day_label.text = "Day " + str(day + 1)


func _amfm_hour(hour:int) -> String:
	if hour == 0:
		return str(12)
	if hour > 12:
		return str(hour - 12)
	return str(hour)

func _minute(minute:int) -> String:
	if minute < 10:
		return "0" + str(minute)
	return str(minute)

func _am_pm(hour:int) -> String:
	if hour < 12:
		return "AM"
	else:
		return "PM"

func _remap_rangef(input:float, minInput:float, maxInput:float, minOutput:float, maxOutput:float):
	return float(input - minInput) / float(maxInput - minInput) * float(maxOutput - minOutput) + minOutput
