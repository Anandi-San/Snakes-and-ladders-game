extends Node2D
onready var ui_pertanyaan = $ui_pertanyaan

# Declare member variables here. Examples:
# var a = 2
# var b = "text"
var pname = 1
var dicePose = [79.46,958.187]
var playerRun = [0,0]
var DiceFace = 0
var localPos = [29.707,833.983]
var countp1 = -1
var countp2 = -1
var snakeStart = [26,95,92,98,74,69,31,37]
var snakeEnd = [5,75,70,36,53,49,7,22]
var ladderStart = [2,61,72,33,27]
var ladderEnd = [24,83,86,64,89]
var questions = [
	{
		"question": "Apa output dari kode berikut?\nnumbers = [1, 2, 3, 4, 5]\ntotal = 0\nfor num in numbers:\n    total += num\nprint(total)",
		"options": ["a) 10", "b) 15 ", "c) 20", "d) 25"],
		"correct_answer_index": 1
	},
	{
		"question": "Apa fungsi dari metode append() pada objek list dalam Python?",
		"options": ["a) Mengurutkan elemen list", "b) Menambahkan elemen ke akhir list", "c) Menghapus elemen dari list", "d) Mencari elemen dalam list"],
		"correct_answer_index": 1
	},
	{
		"question": "Bagaimana cara membaca input dari pengguna dalam Python?",
		"options": ["a) read_input()", "b) get_user_input()", "c) input() ", "d) get_input()"],
		"correct_answer_index": 2
	},
	{
		"question": "Apa hasil dari operasi 3 // 2 dalam Python?",
		"options": ["a) 1.5", "b) 1", "c) 2", "d) 0.5"],
		"correct_answer_index": 1
	},
	{
		"question": "Bagaimana cara mengonversi sebuah string menjadi integer di Python?",
		"options": ["a) str_to_int()", "b) int(string)", "c) convert_int(string)", "d) string.integer()"],
		"correct_answer_index": 1
	},
	{
		"question": "Apa perbedaan antara == dan is dalam Python?",
		"options": ["a) Keduanya digunakan untuk perbandingan nilai", "b) == digunakan untuk perbandingan nilai, sedangkan is untuk perbandingan identitas objek", "c) is digunakan untuk perbandingan nilai, sedangkan == untuk perbandingan identitas objek", "d) Keduanya ekuivalen dan dapat saling menggantikan"],
		"correct_answer_index": 1
	},
	{
		"question": "Apa yang akan dihasilkan dari eksekusi kode berikut?\nprint(\"Hello\" + 3)",
		"options": ["a) Error", "b) Hello3", "c) Hello", "d) 3"],
		"correct_answer_index": 0
	},
	{
		"question": "Bagaimana cara menghitung panjang (jumlah elemen) dari list di Python?",
		"options": ["a) count()", "b) length()", "c) len()", "d) size()"],
		"correct_answer_index": 2
	},
	{
		"question": "Apa output dari kode berikut?\nword = \"Python\"\nprint(word[1:4])",
		"options": ["a) Py", "b) yth", "c) ytho", "d) hon"],
		"correct_answer_index": 1
	},
	{
		"question": "Apa hasil dari operasi 2 ** 3 dalam Python?",
		"options": ["a) 5", "b) 6", "c) 8", "d) 16"],
		"correct_answer_index": 2
	},
	{
		"question": "Apa yang dihasilkan oleh fungsi type(3.14)?",
		"options": ["a) int", "b) float", "c) str", "d) list"],
		"correct_answer_index": 1
	},
	{
		"question": "Bagaimana cara menghapus elemen dengan nilai tertentu dari sebuah list di Python?",
		"options": ["a) list.remove(value)", "b) list.delete(value)", "c) list.pop(value)", "d) list.discard(value)"],
		"correct_answer_index": 0
	},
	{
		"question": "Apa output dari kode berikut?\nnumbers = [1, 2, 3, 4, 5]\nprint(numbers[-2])",
		"options": ["a) 4 ", "b) 2", "c) 3", "d) 5"],
		"correct_answer_index": 0
	},
	{
		"question": "Apa fungsi dari metode upper() pada objek string dalam Python?",
		"options": ["a) Mengubah semua karakter menjadi huruf kecil", "b) Mengubah semua karakter menjadi huruf besar", "c) Menghapus karakter spasi di awal dan akhir string", "d) Membalik urutan karakter dalam string"],
		"correct_answer_index": 1
	},
	{
		"question": "Apa yang dihasilkan oleh operasi 5 % 2 dalam Python?",
		"options": ["a) 2.5", "b) 2", "c) 1 ", "d) 0.5"],
		"correct_answer_index": 2
	},
	{
		"question": "Apa hasil dari operasi not True dalam Python?",
		"options": ["a) True", "b) False ", "c) 0", "d) 1"],
		"correct_answer_index": 1
	}
]
var currentQuestionIndex = 0
var isWaitingForAnswer = false
 
onready var pathFinder = [$Path2D/Blue/Sprite,$Path2D/Red/Sprite]

# Called when the node enters the scene tree for the first time.
func _ready():
	$DiceFaces.show() # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass

func _on_Button_pressed():
	$DiceMusic.play()
	randomize()
	DiceFace = randi() % 6 +1
	$DiceFaces.set_frame(DiceFace - 1)

	pname = !pname
	var pathpos = $Path2D.get_curve().get_point_position(0)

	if not pname:
		$Label.text = "PLAYER 2"
		countp2 += DiceFace
#		countp2 = checkCount(countp2)
		pathpos = $Path2D.get_curve().get_point_position(countp2)
		pathpos.x -= localPos[0]
		pathpos.y -= localPos[1]
		pathpos.y += 5
		pathFinder[1].position = pathpos
		print(countp2)
		checkEvent(countp2)
		checkwin(countp2)
	else:
		$Label.text = "PLAYER 1"
		countp1 += DiceFace
#		countp1 = checkCount(countp1)
		pathpos = $Path2D.get_curve().get_point_position(countp1)
		pathpos.x -= localPos[0]
		pathpos.y -= localPos[1]
		pathFinder[0].position = pathpos
		print(countp1)
		checkEvent(countp1)
		checkwin(countp1)
		
func checkEvent(position):
	print("CHECK EVENT ", position)
	for i in range(snakeStart.size()):
		if position == snakeStart[i]:
			ui_pertanyaan.showQuestion(i, "snake")
			print("ada snake")
			return
	for j in range(ladderStart.size()):
		if position == ladderStart[j]:
			ui_pertanyaan.showQuestion(j, "ladder")
			print("ada ladder")
			return
			
func doEvent():
	var pathpos = $Path2D.get_curve().get_point_position(0)

	if not pname:
		$Label.text = "PLAYER 2"
		countp2 = checkCount(countp2)
		pathpos = $Path2D.get_curve().get_point_position(countp2)
		pathpos.x -= localPos[0]
		pathpos.y -= localPos[1]
		pathpos.y += 5
		pathFinder[1].position = pathpos
		checkwin(countp2)
	else:
		$Label.text = "PLAYER 1"
		countp1 = checkCount(countp1)
		pathpos = $Path2D.get_curve().get_point_position(countp1)
		pathpos.x -= localPos[0]
		pathpos.y -= localPos[1]
		pathFinder[0].position = pathpos
		checkwin(countp1)

func checkCount(c):
	for i in len(snakeStart):
		if c == snakeStart[i]:
			return snakeEnd[i]
	for j in len(ladderStart):
		if c == ladderStart[j]:
			return ladderEnd[j]	
	return c

func checkwin(c):
	if c>=100:
		if c == countp1:
			$Label.text = "PLAYER 1 HAS WON THE GAME"
		else:
			$Label.text = "PLAYER 2 HAS WON THE GAME"
		$DiceFaces/Button.disabled = true
		



func _on_Quit_pressed():
	get_tree().quit()
	
func _on_Restart_pressed():
	get_tree(). reload_current_scene()  # Replace with function body.
