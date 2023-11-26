extends Node2D

var numBoxes = 40
var textureWhite
var textureGreen
var boxWidth
var boxHeight
var startX
var startY
var columnCounter = 0
var rowCounter = 0
var isGreenStart = false
var scaleAmount = 3  # Faktor skala untuk memperbesar kotak

func _ready():
	textureWhite = preload("res://KotakPutih.png")
	textureGreen = preload("res://KotakHijau.png")
	boxWidth = textureWhite.get_width() * scaleAmount
	boxHeight = textureWhite.get_height() * scaleAmount
	startX = (get_viewport_rect().size.x - (8 * boxWidth)) / 2  # Pusat layar permainan - setengah dari lebar susunan kotak
	startY = (get_viewport_rect().size.y - (3 * boxHeight)) / 2 - 50  # Pusat layar permainan - setengah dari tinggi susunan kotak, dikurangi 50 piksel
	createBoxes()

func createBoxes():
	for i in range(numBoxes):
		var box = createBox(i)
		box.scale.x = scaleAmount
		box.scale.y = scaleAmount
		box.position.x = startX + boxWidth * columnCounter
		box.position.y = startY + boxHeight * rowCounter
		columnCounter += 1
		if columnCounter == 8:
			columnCounter = 0
			rowCounter += 1
			isGreenStart = !isGreenStart

func createBox(index):
	var box = Sprite.new()
	var texturePath = textureWhite  # Default texture
	if (isGreenStart and index % 2 == 0) or (!isGreenStart and index % 2 != 0):
		texturePath = textureGreen  # Green texture
	box.texture = texturePath

	add_child(box)  # Tambahkan kotak sebagai anak di lapisan pertama

	var label = Label.new()
	label.text = str(index + 1)
	label.align = Label.ALIGN_CENTER  # Pusatkan teks di label
	label.valign = Label.VALIGN_CENTER
	label.rect_position.x = boxWidth / 2 - label.get_combined_minimum_size().x / 2  # Letakkan label di tengah kotak secara horizontal
	label.rect_position.y = boxHeight / 2 - label.get_combined_minimum_size().y / 2  # Letakkan label di tengah kotak secara vertikal
	add_child_below_node(box, label)  # Tambahkan label di bawah kotak

	return box





