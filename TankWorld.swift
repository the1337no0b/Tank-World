//complete*

class TankWorld {
	var grid = [[gameObject?]] ()
	var turn: Int
	var topLine: String = "."
	var fullContent: String = ""
	init() {
		grid = Array(repeating: Array(repeating: nil, count: 15), count: 15)
		turn = 1
	}
	func addGameObject(GameObject: GameObject, position: Position) {
		grid[position.row][position.col] = GameObject
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
