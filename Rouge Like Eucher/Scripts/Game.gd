extends Node2D

signal reShuffle
const CARDS = preload("res://Scenes/card_control.tscn")
const COIN = preload("res://Scenes/coin.tscn")
@onready var player_turn = $playerTurn
@onready var animation_player = $AnimationPlayer
@onready var notlead = $notLead
@onready var trumpheart = $trumpHeart
@onready var trumpdimond = $trumpdimond
@onready var trumpclub = $trumpclub
@onready var trumpspade = $trumpspade
@onready var leadheart = $leadheart
@onready var leaddimond = $leaddimond
@onready var leadclub = $leadclub
@onready var leadspade = $leadspade
@onready var leadnone = $leadnone
@onready var youwon = $youwon
@onready var youlost = $youlost
@onready var round_won = $RoundWon
@onready var round_lost = $RoundLost
@onready var click_here = $"click here"
@onready var title = $title
@onready var fire = $fire
@onready var card_slide = $"card slide"
@onready var button_press = $"button press"
@onready var how_to_button = $"how to button"
@onready var how_to_play_prompt = $"HowToPlay Prompt"
@onready var yee_haa_button = $"yee haa button"
@onready var side_button_out = $"Side Button out"
@onready var side_bar = $"side bar"
@onready var side_button_in = $"Side button in"


var trump = ['noSuit','nocolor']
var lead = ['none', 'none']
var turn = false
var roundPoints = 0
var pRoundPoints = 0
var enemyPoints = 0
var gamePoints = 0
var playerPlayedCard = []
var e1PlayedCard = []
var e2PlayedCard = []

var heartAceCard = ['ace', 'red', 'heart', 14, 'heartAce']
var heartKingCard = ['king', 'red', 'heart', 13, 'heartKing']
var heartQueenCard = ['queen', 'red', 'heart', 12, 'heartQueen']
var heartJackCard = ['jack', 'red', 'heart', 11, 'heartJack']
var heartTenCard = ['ten', 'red', 'heart', 10, 'heartTen']
var heartNineCard = ['nine', 'red', 'heart', 9, 'heartNine']

var dimondAceCard = ['ace', 'red', 'dimond', 14, 'dimondAce']
var dimondKingCard = ['king', 'red', 'dimond', 13, 'dimondKing']
var dimondQueenCard = ['queen', 'red', 'dimond', 12, 'dimondQueen']
var dimondJackCard = ['jack', 'red', 'dimond', 11, 'dimondJack']
var dimondTenCard = ['ten', 'red', 'dimond', 10, 'dimondTen']
var dimondNineCard = ['nine', 'red', 'dimond', 9, 'dimondNine']

var clubAceCard = ['ace', 'black', 'club', 14, 'clubAce']
var clubKingCard = ['king', 'black', 'club', 13, 'clubKing']
var clubQueenCard = ['queen', 'black', 'club', 12, 'clubQueen']
var clubJackCard = ['jack', 'black', 'club', 11, 'clubJack']
var clubTenCard = ['ten', 'black', 'club', 10, 'clubTen']
var clubNineCard = ['nine', 'black', 'club', 9, 'clubNine']

var spadeAceCard = ['ace', 'black', 'spade', 14, 'spadeAce']
var spadeKingCard = ['king', 'black', 'spade', 13, 'spadeKing']
var spadeQueenCard = ['queen', 'black', 'spade', 12, 'spadeQueen']
var spadeJackCard = ['jack', 'black', 'spade', 11, 'spadeJack']
var spadeTenCard = ['ten', 'black', 'spade', 10, 'spadeTen']
var spadeNineCard = ['nine', 'black', 'spade', 9, 'spadeNine']

var CARDLIST = [heartAceCard, heartKingCard, heartQueenCard, heartJackCard, heartTenCard, heartNineCard,
dimondAceCard, dimondKingCard, dimondQueenCard, dimondJackCard, dimondTenCard, dimondNineCard,
clubAceCard, clubKingCard, clubQueenCard, clubJackCard, clubTenCard, clubNineCard,
spadeAceCard, spadeKingCard, spadeQueenCard, spadeJackCard, spadeTenCard, spadeNineCard,]

var gameDeck = CARDLIST
var playerHand = []
var enemy1Hand = []
var enemy2Hand = []
var friendHand = []
var burried = []
var peoplesHands = [playerHand, enemy1Hand, enemy2Hand, friendHand]

#func playCard(trump,lead):
	#if cardSuit == trump[0]:
		#if cardName == 'jack':
			#return cardValue*3
		#else:
			#return cardValue * 2
	#elif cardColor == trump[1] and cardName == 'jack':
		#return (cardValue*3)-1
	#elif cardSuit == lead:
		#return cardValue
	#else:
		#return 0

func removeChild(parent):
	for n in parent.get_children():
		parent.remove_child(n)
		n.queue_free()
		
func _ready():
	fire.play()

func _on_deal_button_shuffle():
	yee_haa_button.visible = false
	how_to_button.visible = false
	how_to_play_prompt.visible = false
	card_slide.play()
	click_here.visible = false
	title.visible = false
	playerHand = []
	enemy1Hand = []
	enemy2Hand = []
	friendHand = []
	burried = []
	gameDeck = [heartAceCard, heartKingCard, heartQueenCard, heartJackCard, heartTenCard, heartNineCard,
dimondAceCard, dimondKingCard, dimondQueenCard, dimondJackCard, dimondTenCard, dimondNineCard,
clubAceCard, clubKingCard, clubQueenCard, clubJackCard, clubTenCard, clubNineCard,
spadeAceCard, spadeKingCard, spadeQueenCard, spadeJackCard, spadeTenCard, spadeNineCard,]
	
	
	while gameDeck.size() >4:
		var peoplesHands = [playerHand, enemy1Hand, enemy2Hand, friendHand]
		for i in range(4):
			var chosenCard = randi_range(0,gameDeck.size()-1)
			peoplesHands[0].append(gameDeck[chosenCard])
			peoplesHands.remove_at(0)
			gameDeck.remove_at(chosenCard)
	for card in gameDeck:	
		burried.append(card)
	
	for i in range(5):
		var newcard = CARDS.instantiate()
		%playerHand.add_child(newcard)
		newcard.setCard(playerHand[i][0],playerHand[i][1],playerHand[i][2],playerHand[i][3],playerHand[i][4],0,'player')
	
	for i in range(5):
		var newCard = CARDS.instantiate()
		%Enemy1Hand.add_child(newCard)
		newCard.setCard(enemy1Hand[i][0],enemy1Hand[i][1],enemy1Hand[i][2],enemy1Hand[i][3],'cardBack',1.57,'enemy1')
	
	for i in range(5):
		var newCard = CARDS.instantiate()
		%Enemy2Hand.add_child(newCard)
		newCard.setCard(enemy2Hand[i][0],enemy2Hand[i][1],enemy2Hand[i][2],enemy2Hand[i][3],'cardBack',-1.57,'ememy2')
		
	for i in range(5):
		var newCard = CARDS.instantiate()
		%FriendlyHand.add_child(newCard)
		newCard.setCard(friendHand[i][0],friendHand[i][1],friendHand[i][2],friendHand[i][3],'cardBack',0,'friendly')
	await get_tree().create_timer(.3).timeout
	animation_player.queue("TrumpPannle")
	


func _on_control_trump_is_heart():
	button_press.play()
	trump = ['heart', 'red']
	animation_player.queue("pannleLeave")
	dimondJackCard[2] = 'heart'
	dimondJackCard[3] -=1
	trumpheart.visible = true
	gameLoopP1()


func _on_control_trump_is_dimonod():
	button_press.play()
	trump = ['dimond', 'red']
	animation_player.queue("pannleLeave")
	heartJackCard[2] = 'dimond'
	heartJackCard[3] -=1
	trumpdimond.visible = true

	gameLoopP1()


func _on_control_trump_is_club():
	button_press.play()
	trump = ['club', 'black']
	animation_player.queue("pannleLeave")
	spadeJackCard[2] = 'club'
	spadeJackCard[3] -=1
	trumpclub.visible = true
	gameLoopP1()


func _on_control_trump_is_spade():
	button_press.play()
	trump = ['spade', 'black']
	animation_player.queue("pannleLeave")
	clubJackCard[2] = 'spade'
	clubJackCard[3] -=1
	trumpspade.visible = true
	gameLoopP1()


func enemy1AI():
	card_slide.play()
	var e1cardRank = []
	for i in (enemy1Hand.size()):
		e1cardRank.append(1)
	if lead[0] == 'none':
		for i in (enemy1Hand.size()):
			if enemy1Hand[i][0]=='jack' and enemy1Hand[i][2]== trump[0] and enemy2Hand[i][3] == 11:
				e1cardRank[i]*= 3
			elif enemy1Hand[i][2] != trump[0]:
				e1cardRank[i] *= 2
			e1cardRank[i]*=enemy1Hand[i][3]
			
	else:
		for i in range(enemy1Hand.size()):
			if enemy1Hand[i][2]== lead[0]:
				e1cardRank[i]*=10
			if enemy1Hand[i][0]=='jack' and enemy1Hand[i][2]== trump[0]:
				e1cardRank[i]*= 4
			elif enemy1Hand[i][0]=='jack' and enemy1Hand[i][1]== trump[1]:
				e1cardRank[i]*= 3
			elif enemy1Hand[i][2]== trump[0]:
				e1cardRank[i]*= 2
			e1cardRank[i]*=enemy1Hand[i][3]
	var bestRank1 = e1cardRank[0]
	for rank in e1cardRank:
		if bestRank1 < rank:
			bestRank1= rank
	e1PlayedCard = enemy1Hand[e1cardRank.find(bestRank1)]
	enemy1Hand.remove_at(e1cardRank.find(bestRank1))
	if lead[0] == 'none':
		lead[0] = e1PlayedCard[2]
	removeChild(%Enemy1Hand)
	for i in range(enemy1Hand.size()):
		var newCard = CARDS.instantiate()
		%Enemy1Hand.add_child(newCard)
		newCard.setCard(enemy1Hand[i][0],enemy1Hand[i][1],enemy1Hand[i][2],enemy1Hand[i][3],'cardBack',1.57, 'enemy1')
		
	var newCard = CARDS.instantiate()
	%Enemy1Played.add_child(newCard)
	newCard.setCard(e1PlayedCard[0],e1PlayedCard[1],e1PlayedCard[2],e1PlayedCard[3],e1PlayedCard[4],1.57, 'game')
	
	
func enemy2AI():
	card_slide.play()
	var e2cardRank = []
	for i in (enemy2Hand.size()):
		e2cardRank.append(1)
	if lead[0] == 'none':
		for i in (enemy2Hand.size()):
			if enemy2Hand[i][0]=='jack' and enemy2Hand[i][2]== trump[0] and enemy2Hand[i][3] == 11:
				e2cardRank[i]*= 3
			elif enemy2Hand[i][2] != trump[0]:
				e2cardRank[i] *= 2
			e2cardRank[i]*=enemy2Hand[i][3]
			
	else:
		for i in range(enemy2Hand.size()):
			if enemy2Hand[i][2]== lead[0]:
				e2cardRank[i]*=10
			if enemy2Hand[i][0]=='jack' and enemy2Hand[i][2]== trump[0]:
				e2cardRank[i]*= 4
			elif enemy2Hand[i][0]=='jack' and enemy2Hand[i][1]== trump[1]:
				e2cardRank[i]*= 3
			elif enemy2Hand[i][2]== trump[0]:
				e2cardRank[i]*= 2
			e2cardRank[i]*=enemy2Hand[i][3]
	var bestRank2 = e2cardRank[0]
	for rank in e2cardRank:
		if bestRank2 < rank:
			bestRank2= rank
	e2PlayedCard = enemy2Hand[e2cardRank.find(bestRank2)]
	enemy2Hand.remove_at(e2cardRank.find(bestRank2))
	if lead[0] == 'none':
		lead[0] = e2PlayedCard[2]
	removeChild(%Enemy2Hand)
	for i in range(enemy2Hand.size()):
		var newCard = CARDS.instantiate()
		%Enemy2Hand.add_child(newCard)
		newCard.setCard(enemy2Hand[i][0],enemy2Hand[i][1],enemy2Hand[i][2],enemy2Hand[i][3],'cardBack',-1.57, 'enemy2')
		
	var newCard = CARDS.instantiate()
	%Enemy2Played.add_child(newCard)
	newCard.setCard(e2PlayedCard[0],e2PlayedCard[1],e2PlayedCard[2],e2PlayedCard[3],e2PlayedCard[4],-1.57, 'game')
	
	
func gameLoopP1():
	var player = CARDS.instantiate()
	if lead[1] == 'enemy1' or lead[1] == 'none':
		await get_tree().create_timer(.5).timeout
		enemy1AI()
		await get_tree().create_timer(.5).timeout
		enemy2AI()
		player_turn.visible= true
		turn = true
		player.playerTurn()
	elif lead[1] == 'enemy2':
		await get_tree().create_timer(.5).timeout
		enemy2AI()
		player_turn.visible= true
		turn = true
		player.playerTurn()
	else:
		player_turn.visible= true
		await get_tree().create_timer(.5).timeout
		turn = true
		player.playerTurn()
	


func _on_cards_card_chosen(names, color, suit, value, sprite, rotated, newowner):
	card_slide.play()
	playerPlayedCard = [names, color, suit, value, sprite]
	var leadNum = 0
	for card in playerHand:
		if lead[0] == card[2]:
			leadNum +=1
	if turn == false:
		pass
	elif playerPlayedCard[2] != lead[0] and leadNum != 0:
		notlead.visible = true
		await get_tree().create_timer(.5).timeout
		notlead.visible = false 
	else:
		if lead[0] == 'none':
			lead[0] = playerPlayedCard[2]
		playerHand.remove_at(playerHand.find(playerPlayedCard))
		removeChild(%playerHand)
		for i in range (playerHand.size()):
			var newCard = CARDS.instantiate()
			%playerHand.add_child(newCard)
			newCard.setCard(playerHand[i][0],playerHand[i][1],playerHand[i][2],playerHand[i][3],playerHand[i][4],0,'player')
		var newCard = CARDS.instantiate()
		%PlayerPlayed.add_child(newCard)
		newCard.setCard(playerPlayedCard[0],playerPlayedCard[1],playerPlayedCard[2],playerPlayedCard[3],playerPlayedCard[4],0, 'game')
		
		gameLoopP2()

func gameLoopP2():
	player_turn.visible= false
	if lead[1] == 'enemy1' or lead[1] == 'none':
		calculate(playerPlayedCard[0],playerPlayedCard[1],playerPlayedCard[2],playerPlayedCard[3],e1PlayedCard[0],e1PlayedCard[1],e1PlayedCard[2],e1PlayedCard[3],e2PlayedCard[0],e2PlayedCard[1],e2PlayedCard[2],e2PlayedCard[3])
		
	elif lead[1] == 'enemy2':
		await get_tree().create_timer(.5).timeout
		enemy1AI()
		calculate(playerPlayedCard[0],playerPlayedCard[1],playerPlayedCard[2],playerPlayedCard[3],e1PlayedCard[0],e1PlayedCard[1],e1PlayedCard[2],e1PlayedCard[3],e2PlayedCard[0],e2PlayedCard[1],e2PlayedCard[2],e2PlayedCard[3])
	else:
		await get_tree().create_timer(.5).timeout
		enemy1AI()
		await get_tree().create_timer(.5).timeout
		enemy2AI()
		calculate(playerPlayedCard[0],playerPlayedCard[1],playerPlayedCard[2],playerPlayedCard[3],e1PlayedCard[0],e1PlayedCard[1],e1PlayedCard[2],e1PlayedCard[3],e2PlayedCard[0],e2PlayedCard[1],e2PlayedCard[2],e2PlayedCard[3])


func calculate(pCardn, pCardc, pCards, pCardv, e1Cardn, e1Cardc, e1Cards, e1Cardv, e2Cardn, e2Cardc, e2Cards, e2Cardv):
	var pCardValue = pCardv
	var e1CardValue = e1Cardv
	var e2CardValue = e2Cardv
	if pCardn == 'jack' and pCards== trump[0]:
		pCardValue*=3+1
	elif pCardn == 'jack' and pCardc == trump[1]:
		pCardValue*=3
	elif pCards == trump[0]:
		pCardValue*=2
	elif pCards != lead[0]:
		pCardValue *=0
	
	
	if e1Cardn == 'jack' and e1Cards== trump[0]:
		e1CardValue*=3+1
	elif e1Cardn == 'jack' and e1Cardc == trump[1]:
		e1CardValue*=3
	elif e1Cards == trump[0]:
		e1CardValue*=2
	elif e1Cards != lead[0]:
		e1CardValue *=0
	
	
	if e2Cardn == 'jack' and e2Cards== trump[0]:
		e2CardValue*=3+1
	elif e2Cardn == 'jack' and e2Cardc == trump[1]:
		e2CardValue*=3
	elif e2Cards == trump[0]:
		e2CardValue*=2
	elif e2Cards != lead[0]:
		e2CardValue *=0
	
	
	if pCardValue > e1CardValue:
		if pCardValue > e2CardValue:
			youwon.visible = true
			await get_tree().create_timer(1).timeout
			youwon.visible = false
			lead = ['none', 'player']
			pRoundPoints+=1
			roundPoints +=1
			
		else:
			youlost.visible = true
			await get_tree().create_timer(1).timeout
			youlost.visible = false
			lead = ['none', 'enemy2']
			roundPoints +=1
	else:
		if e1CardValue > e2CardValue:
			youlost.visible = true
			await get_tree().create_timer(1).timeout
			youlost.visible = false
			lead = ['none', 'enemy1']
			roundPoints+=1
		else:
			youlost.visible = true
			await get_tree().create_timer(1).timeout
			youlost.visible = false
			lead = ['none', 'enemy2']
			roundPoints+=1
	if roundPoints >= 5:
		if pRoundPoints==5:
			for num in range(4):
				var newCoin = COIN.instantiate()
				%coinStack.add_child(newCoin)
			round_won.visible = true
			await get_tree().create_timer(1.5).timeout
			round_won.visible = false
		elif pRoundPoints >=3:
			var newCoin = COIN.instantiate()
			%coinStack.add_child(newCoin)
			gamePoints+= 1
			round_won.visible = true
			await get_tree().create_timer(1.5).timeout
			round_won.visible = false
		else:
			enemyPoints+=2
			round_lost.visible = true
			await get_tree().create_timer(1).timeout
			round_lost.visible = false
		lead = ['none', 'none']
		pRoundPoints = 0
		roundPoints = 0
		removeChild(%playerHand)
		removeChild(%FriendlyHand)
		removeChild(%Enemy2Hand)
		removeChild(%Enemy1Hand)
		removeChild(%Enemy1Played)
		removeChild(%Enemy2Played)
		removeChild(%PlayerPlayed)
		player_turn.visible = false
		trumpheart.visible = false
		trumpdimond.visible = false
		trumpclub.visible = false
		trumpspade.visible = false
		spadeJackCard = ['jack', 'black', 'spade', 11, 'spadeJack']
		clubJackCard = ['jack', 'black', 'club', 11, 'clubJack']
		heartJackCard = ['jack', 'red', 'heart', 11, 'heartJack']
		dimondJackCard = ['jack', 'red', 'dimond', 11, 'dimondJack']
		reShuffle.emit()
		
	else:
		gameLoopP1()
			


func _on_side_button_out_pressed():
	button_press.play()
	side_button_out.visible = false
	side_bar.visible = true
	side_button_in.visible = true
	


func _on_side_button_in_pressed():
	button_press.play()
	side_button_out.visible = true
	side_bar.visible = false
	side_button_in.visible = false
	



func _on_how_to_button_pressed():
	button_press.play()
	how_to_button.visible = false
	how_to_play_prompt.visible = true
	yee_haa_button.visible = true




func _on_yee_haa_button_pressed():
	button_press.play()
	how_to_button.visible = true
	how_to_play_prompt.visible = false
	yee_haa_button.visible = false
