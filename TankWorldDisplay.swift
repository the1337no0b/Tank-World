//put the grid printout here

extension TankWorld {
  
  func printGrid() -> String
  {
    topLine = ""
    fullContent = ""
		for row in 0..<grid.count {
			var content1: String = "|"
			var content2: String = "|"
			var content3: String = "|"
			//var topLine: String = "."
			var bottomText: String = "|"
			for col in 0..<grid.count {
				if grid[row][col] != nil {
          //"\(grid[row][col]!.position.row, grid[row][col]!.position.col)
					content1 += "\(fit("\(grid[row][col]!.energy)", 7, right: true))|"
          content2 += "\(fit("\(grid[row][col]!.position.row, grid[row][col]!.position.col)", 7, right: true))|"
          content3 += "\(fit("\(grid[row][col]!.id)", 7, right: true))|"
				}
				else {
					content1 += "       |"
					content2 += "       |"
					content3 += "       |"
				}
				bottomText += "_______|"
			}
			topLine += "_______."
			fullContent += "\(content1)\n\(content2)\n\(content3)\n\(bottomText)\n"
		}
	return ("\(topLine)\n\(fullContent)")
	}
}
