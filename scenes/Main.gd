extends Control

@onready var QuestionItems = $VBoxContainer/QuestionTexts
@onready var AnswersList = $AnswersList
@onready var QuestionImage = $ImageRect
@onready var RestartButton = $RestartButton
@onready var WrongNumber = $WrongNumber
@onready var ScoreNumber = $ScoreNumber
@onready var CorrectAnswer = $CorrectAnswer
@onready var OKButton = $OK

var items: Array = read_json_file("res://assets/texts/questions.json")
var item: Dictionary
var index_item: int = 0
var wrong: int = 0
var correct: float = 0

func _ready():
	show_questions()
	displayScore()	

func displayScore():
	WrongNumber.text = "Wrong: " + str(wrong)
	ScoreNumber.text = "Score: " + str(correct)+"/"+str(items.size())

func show_questions():
	CorrectAnswer.hide()
	OKButton.hide()
	AnswersList.show()
	QuestionImage.show()
	ScoreNumber.show()
	RestartButton.hide()
	AnswersList.clear()
	WrongNumber.show()
	item = items[index_item]
	QuestionItems.text = item.question
	print(item.imagePath)
	QuestionImage.texture = load(item.imagePath)
	var options = item.options
	for option in options:
		AnswersList.add_item(option)

func show_result():
	displayScore()
	AnswersList.hide()
	QuestionImage.hide()
	CorrectAnswer.hide()
	OKButton.hide()
	RestartButton.show()
	WrongNumber.show()
	ScoreNumber.show()
	
	var percentage = round(correct/items.size()*100)
	var greet
	if percentage >= 60:
		greet = "Very good!"
	else:
		greet = "Too bad!"
	QuestionItems.text = "{greet} You're correct {percentage} %".format({"greet": greet, "percentage": percentage})

func refresh_scene():
	if index_item >= items.size():
		show_result()
	else:
		show_questions()
		displayScore()

func read_json_file(filename):
	var json_as_text = FileAccess.get_file_as_string(filename)
	var json_as_dict = JSON.parse_string(json_as_text)
	print(json_as_dict)
	return json_as_dict

func show_correct_answer():
	AnswersList.hide()	
	ScoreNumber.hide()
	RestartButton.hide()
	QuestionImage.show()
	CorrectAnswer.show()
	OKButton.show()
	WrongNumber.hide()
	item = items[index_item]
	CorrectAnswer.text = "The correct answer is: " + item.options[item.correctOptionIndex]

func _on_ok_pressed():
	index_item +=1
	refresh_scene()

func _on_answers_list_item_selected(index):
	if index == item.correctOptionIndex:
		correct +=1
		index_item +=1
		refresh_scene()
	else:
		wrong +=1
		show_correct_answer()
		
func _on_restart_button_pressed():
	correct = 0
	wrong = 0
	ScoreNumber.text = str(correct)
	index_item = 0	
	refresh_scene()
