class TankWorld: CustomStringConvertible {

	var topLine: String = "."
	var bottomText: String = "|"
	//let gridSize = 5
	var gridID: [String] = Array(repeating: Array(repeating: 0, count: 5), count: 5)
	var gridEnergy = Array(repeating: Array(repeating: 0, count: 5), count: 5)
	var gridLocation = Array(repeating: Array(repeating: 0, count: 5), count: 5)

	func array1Dboxes(array: [Int]) -> String {
		var content: String = "|"
		bottomText = "|"
			for i in array {
				if i == 0 {
					content += "       |"
				}
				else {
					content += "   \(i)   |"
				}
				bottomText += "_______|"
			}
		return content
	}

	func addTopLine() {
		for _ in gridID {
			topLine += "_______."
		}
	}

	//func addValues(valueArray: [Int])

	func placeGameObjects(go: gameObject) {
		let xCoor: Int = go.location[0]
		let yCoor: Int = go.location[1]
		//print(xCoor, yCoor)
		gridID[xCoor][yCoor] = go.id
		gridEnergy[xCoor][yCoor] = go.energy
		//gridLocation[xCoor][yCoor] = go.location
	}

	var description: String {
		addTopLine()
		var resultGrid: String = "\(topLine)\n"
		for row in 0..<gridID.count {
			resultGrid += "\(array1Dboxes(array: gridID[row]))\n"
			resultGrid += "\(array1Dboxes(array: gridEnergy[row]))\n"
			resultGrid += "\(array1Dboxes(array: gridLocation[row]))\n"
			resultGrid += "\(bottomText)\n"
		}
		return resultGrid
	}
}
