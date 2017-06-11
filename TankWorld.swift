//complete*

class TankWorld {
	var grid = [[gameObject?]] ()
	var turn: Int = 0
	var topLine: String = "."
	var fullContent: String = ""
	let numberRows: Int
	let numberCols: Int
	var gameOver = false
	var lastLivingTank: Tank? = nil
	var numberLivingTanks = 0
	init() {
		self.numberRows = rows
		self.numberCols = cols
		grid = Array(repeating: Array(repeating: nil, count: cols), count: rows)
	}
	func addGameObject(GameObject: GameObject, position: Position) {
		grid[position.row][position.col] = GameObject
	}
	func handleRadar(tank: Tank)
	{
		guard let radarAction = tank.preActions[.RunRadar] else {return}
		actionRunRadar(tank: tank, runRadarAction: radarAction as! RunRadarAction)
	}
	func handleSendMessage(tank: Tank)
	{
		guard let sendMessageAction = tank.preActions[.SendMessage] else {return}
		actionSendMessage(tank: tank, sendMessageAction: sendMessageAction as! SendMessageAction)
	}
	func handleReceiveMessage(tank: Tank)
	{
		guard let receiveMessageAction = tank.preActions[.ReceiveMessage] else {return}
		actionReceiveMessage(tank: tank, receiveMessageAction: receiveMessageAction as! ReceiveMessageAction)
	}
	func handleSetShields(tank: Tank)
	{
		guard let setShieldsAction = tank.preActions[.SetShields] else {return}
		actionSetShields(tank: tank, setShieldsAction: setShieldsAction as! SetShieldsAction)
	}
	func handleFireMissle(tank: Tank)
	{
		guard let fireMissleAction = tank.postActions[.FireMissle] else {return}
		actionFireMissle(tank: tank, fireMissleAction: fireMissleAction as! FireMissleAction)
	}
	func handleMove(tank: Tank)
	{
		guard let moveAction = tank.postActions[.Move] else {return}
		actionMove(tank: tank, moveAction: moveAction as! MoveAction)
	}
	func doTurn() {
		print(display())
		print(logger.log)
		nextTurn()
	}
	func nextTurn() {
		turn += 1
		logger.log = ""
	}
}
