extends CanvasLayer
var jawaban = false
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
var event = null


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

func generate(soal):
	pass
# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
func showQuestion(index, _event):
	$ColorRect/Label_notif.text = ""
	print("SHOW QUESTION")
	self.visible = true
	currentQuestionIndex = index
	isWaitingForAnswer = true
	event = _event
	print(questions.size())
	var question = questions[rand_range(0,questions.size()-1)]
	# Tampilkan pertanyaan dan opsi di GUI Anda, misalnya di panel atau label
	$ColorRect/Panel/Label.text = question["question"]
	$ColorRect/Button/Label.text = question["options"][0]
	$ColorRect/Button2/Label.text = question["options"][1]
	$ColorRect/Button3/Label.text = question["options"][2]
	$ColorRect/Button4/Label.text = question["options"][3]
	
func _on_AnswerButton_pressed(option):
	if isWaitingForAnswer:
		isWaitingForAnswer = false
		var question = questions[currentQuestionIndex]
		var correctAnswerIndex = question["correct_answer_index"]
		if option == correctAnswerIndex:
			# Jawaban benar, lakukan aksi yang sesuai (naik tangga)
			if event == "ladder" :
				$ColorRect/Label_notif.text = "Jawaban Benar, Naik Tangga!"
			if event == "snake":
				$ColorRect/Label_notif.text = "Jawaban Benar, Tidak Turun!"
			jawaban = true
		else:
			# Jawaban salah, lakukan aksi yang sesuai (turun ular)
			if event == "ladder" :
				$ColorRect/Label_notif.text = "Jawaban Salah, Tidak Naik Tangga!"
			if event == "snake":
				$ColorRect/Label_notif.text = "Jawaban Salah, Turun Ular!"
			jawaban = false
		$Timer.start(3)


func _on_Timer_timeout():
	self.visible = false
	if event == "ladder" and jawaban == true:
		get_parent().doEvent()
	if event == "snake" and jawaban == false:
		get_parent().doEvent()
	pass # Replace with function body.
