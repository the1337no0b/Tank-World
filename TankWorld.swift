//complete*

class TankWorld
{
	var grid: [[gameObject?]]
	var turn: Int = 0
	var topLine: String = "."
	var fullContent: String = ""
	let numberRows: Int
	let numberCols: Int
	var logger: Logger = Logger()
	var gameOver = false
	var lastLivingTank: Tank? = nil
	var numberLivingTanks = 0
	init (rows: Int, cols: Int)
	{
		self.numberRows = rows
		self.numberCols = cols
		grid = Array(repeating: Array(repeating: nil, count: cols), count: rows)
	}
	func populateTankWorld()
	{
		addGameObject(gameObject: TankHunter(row: 2, col: 2, name: "King", energy: 30000, id: "HUNT", instructions:""))
		addGameObject(gameObject: TankKing(row: 9, col: 7, name: "Hunter", energy: 30000, id: "KING", instructions:""))
		addGameObject(gameObject: TankHunter(row: 1, col: 4, name: "Test", energy: 30000, id: "HUNT", instructions: ""))
		addGameObject(gameObject: TankHunter(row: 3, col: 6, name: "Tank", energy: 30000, id: "HUNT", instructions: ""))
		addGameObject(gameObject: TestTank(row: 1, col: 1, name: "Tank", energy: 50000, id: "DROP", instructions: ""))
		addGameObject(gameObject: TestTank(row: 2, col: 5, name: "Tank", energy: 50000, id: "DROP", instructions: ""))
	}
	func addGameObject(gameObject: gameObject)
	{
		logger.addLog(gameObject, "Added to TankLand")
		grid[gameObject.position.row][gameObject.position.col] = gameObject
		if gameObject.objectType == .Tank{numberLivingTanks += 1}
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
	func handleDropMine(tank: Tank)
	{
		guard let dropMineAction = tank.postActions[.DropMine] else {return}
		actionDropMine(tank: tank, dropMineAction: dropMineAction as! DropMineAction)
	}
	func gridReport() -> String
	{
		var gridLog = ""
		gridLog += "\n\n\n"
		gridLog += printGrid()
		gridLog += "\n"
		gridLog += "NLT: \(numberLivingTanks) \n"
		gridLog += "Command... \n"
		gridLog += logger.log
		return gridLog

	}
	func doTurn()
	{
		var allObjects = findAllGameObjects()
		allObjects = randomizeGameObjects(gameObjects: allObjects)

		for i in allObjects
		{
			if i.objectType == .Tank
			{
				applyCost(i, amount: Constants.costLifeSupportTank)
				if(isDead(i) == true)
				{
					let clearPosition = i.position
					grid[clearPosition.row][clearPosition.col] = nil
					let check = findWinner()
					if check != nil
					{
						gameOver = true
						lastLivingTank = check!
						return
					}
				}
			}
			else if i.objectType == .Mine
			{
				applyCost(i, amount: Constants.costLifeSupportMine)
				if(isDead(i) == true)
				{
					let clearPosition = i.position
					grid[clearPosition.row][clearPosition.col] = nil
					let check = findWinner()
					if check != nil
					{
						gameOver = true
						lastLivingTank = check!
						return
					}
				}
			}
			else
			{
				applyCost(i, amount: Constants.costLifeSupportRover)
				if(isDead(i) == true)
				{
					let clearPosition = i.position
					grid[clearPosition.row][clearPosition.col] = nil
					let check = findWinner()
					if check != nil
					{
						gameOver = true
						lastLivingTank = check!
						return
					}
				}
			}

		}
		let roverObjects = findAllRovers()
		var checkWin = findWinner()
		for i in roverObjects
		{
			actionMoveRover(rover: i)
			if(isDead(i) == true)
			{
				let clearPosition = i.position
				grid[clearPosition.row][clearPosition.col] = nil
			}
			checkWin = findWinner()
			if checkWin != nil
			{
				gameOver = true
				lastLivingTank = checkWin!
				return
			}
		}
		let tankObjects = findAllTanks()
		numberLivingTanks = tankObjects.count
		//tankObjects = randomizeGameObjects(gameObjects: tankObjects)
		//tankObjects = tankObjects as! [Tank]

		for i in tankObjects
		{
			i.computePreActions()
		}
		for i in tankObjects
		{
			handleRadar(tank: i)
			if(isDead(i) == true)
			{
				let clearPosition = i.position
				grid[clearPosition.row][clearPosition.col] = nil
			}
			checkWin = findWinner()
			if checkWin != nil
			{
				gameOver = true
				lastLivingTank = checkWin!
				return
			}
		}
		for i in tankObjects
		{
			handleSendMessage(tank: i)

			if(isDead(i) == true)
			{
				let clearPosition = i.position
				grid[clearPosition.row][clearPosition.col] = nil
			}
			checkWin = findWinner()
			if checkWin != nil
			{
				gameOver = true
				lastLivingTank = checkWin!
				return
			}
		}
		for i in tankObjects
		{
			handleReceiveMessage(tank: i)

			if(isDead(i) == true)
			{
				let clearPosition = i.position
				grid[clearPosition.row][clearPosition.col] = nil
			}
			checkWin = findWinner()
			if checkWin != nil
			{
				gameOver = true
				lastLivingTank = checkWin!
				return
			}
		}
		for i in tankObjects
		{
			handleSetShields(tank: i)

			if(isDead(i) == true)
			{
				let clearPosition = i.position
				grid[clearPosition.row][clearPosition.col] = nil
			}
			checkWin = findWinner()
			if checkWin != nil
			{
				gameOver = true
				lastLivingTank = checkWin!
				return
			}
		}
		for i in tankObjects
		{
			i.computePostActions()
		}
		for i in tankObjects
		{
			handleDropMine(tank: i)

			if(isDead(i) == true)
			{
				let clearPosition = i.position
				grid[clearPosition.row][clearPosition.col] = nil
			}
			checkWin = findWinner()
			if checkWin != nil
			{
				gameOver = true
				lastLivingTank = checkWin!
				return
			}
			let roverClear = findAllRovers()
			for e in roverClear
			{
				if(isDead(e) == true)
				{
					let clearPosition = e.position
					grid[clearPosition.row][clearPosition.col] = nil
				}
			}
		}
		for i in tankObjects
		{
			handleFireMissle(tank: i)

			if(isDead(i) == true)
			{
				let clearPosition = i.position
				grid[clearPosition.row][clearPosition.col] = nil
			}
			checkWin = findWinner()
			if checkWin != nil
			{
				gameOver = true
				lastLivingTank = checkWin!
				return
			}
			let roverClear = findAllRovers()
			for e in roverClear
			{
				if(isDead(e) == true)
				{
					let clearPositionRover = e.position
					grid[clearPositionRover.row][clearPositionRover.col] = nil
				}
			}
		}
		for i in tankObjects
		{
			handleMove(tank: i)

			if(isDead(i) == true)
			{
				let clearPosition = i.position
				grid[clearPosition.row][clearPosition.col] = nil
			}
			checkWin = findWinner()
			if checkWin != nil
			{
				gameOver = true
				lastLivingTank = checkWin!
				return
			}
			let roverClear = findAllRovers()
			for e in roverClear
			{
				if(isDead(e) == true)
				{
					let clearPositionRover = e.position
					grid[clearPositionRover.row][clearPositionRover.col] = nil
				}
			}
		}
		checkWin = findWinner()
		if checkWin != nil
		{
			gameOver = true
			lastLivingTank = checkWin!
			return
		}
		let newTankObjects = findAllTanks()
		for i in newTankObjects
		{
			i.clearActions()
		}
		//let roverClear = findAllRovers()
		let roverClear = findAllRovers()
		for e in roverClear
		{
			if(isDead(e) == true)
			{
				let clearPositionRover = e.position
				grid[clearPositionRover.row][clearPositionRover.col] = nil
			}
		}
		numberLivingTanks = newTankObjects.count
		turn += 1
	}
	func runOneTurn()
	{
		logger.clearLog()
		doTurn()
		//print("NLT: \(numberLivingTanks)")
		print(gridReport())
		logger.clearLog()
	}
	func driver()
	{
		populateTankWorld()
		print(gridReport())
		//print("NLT: \(numberLivingTanks)")
		while !gameOver
		{
			let turnRun = runTankLand()
			for _ in 0 ..< turnRun
			{
				runOneTurn()
			}
		}
		print("***Winner is... \(lastLivingTank!)")
	}
}
