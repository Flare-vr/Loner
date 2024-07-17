extends Control

@onready var cards = $Cards2
@onready var shadow = $Sprite2D2
@onready var rootNode = $"."
@onready var theGame = rootNode.find_parent('Game')
@onready var audio = $AudioStreamPlayer2D

signal cardChosen
signal PlayerTurn

var cardName = 'ace'
var cardColor = 'red'
var cardSuit = 'heart'
var cardValue = 14
var cardSprite = 'heartAce'
var cardOwner = 'player'
var turn = 0

func _ready():
	cards.play(cardSprite)

func playerTurn():
	turn = 1

func setCard(names, color, suit, value, sprite, rotated, newowner):
	cardName = names
	cardColor = color
	cardSuit = suit
	cardValue = value
	cardSprite = sprite
	cards.play(cardSprite)
	cards.rotate(rotated)
	shadow.rotate(rotated)
	cardOwner = newowner


func _on_card_button_pressed():
	if cardSprite == 'cardBack' or cardOwner != 'player' or turn >0:
		pass
	else:
		turn = 0
		theGame._on_cards_card_chosen(cardName, cardColor, cardSuit, cardValue, cardSprite, 0, 'player')


func _on_card_button_mouse_entered():
	if cardSprite == 'cardBack' or cardOwner != 'player':
		pass
	else:
		audio.play()
		cards.position[1] -=5
	


func _on_card_button_mouse_exited():
	if cardSprite == 'cardBack' or cardOwner != 'player':
		pass
	else:
		cards.position[1] +=5
