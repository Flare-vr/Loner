extends Node
@onready var cards = $Cards
var cardName = 'ace'
var cardColor = 'red'
var cardSuit = 'heart'
var cardValue = 14
var cardSprite = 'heartAce'


func playCard(trump,lead):
	if cardSuit == trump[0]:
		if cardName == 'jack':
			return cardValue*3
		else:
			return cardValue * 2
	elif cardColor == trump[1] and cardName == 'jack':
		return (cardValue*3)-1
	elif cardSuit == lead:
		return cardValue
	else:
		return 0
		
	

