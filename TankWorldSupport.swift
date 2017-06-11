/*still needs *some* support functions:

func randomizeGameObjects
func findwinner
Optional:
func makeOffsetPosition
func findFreeAdjacent
func isGoodIndex
func getRandomDirection
func distance
*/

import Foundation
import Glibc
extension TankWorld
{
  func fitD(_ d: Date, _ size: Int, right: Bool = false) -> String {
	let df = DateFormatter()
	df.dateFormat = "MM-dd-yyyy"
	let dAsString = df.string(from: d)
	return fit(dAsString, size, right: right)
}

func fitI(_ i: Int, _ size: Int, right: Bool = false) -> String {
	let iAsString = "\(i)"
	let newLength = iAsString.characters.count
	return fit(iAsString, newLength > size ? newLength : size , right: right)
}

func fit(_ s: String,_ size: Int, right: Bool = true) -> String {
	var result = ""
	let sSize = s.characters.count
	if sSize == size {return s}
	var count = 0
	if size < size {
		for c in s.characters {
			if count < size {result.append(c)}
			count += 1
		}
		return result
	}
	result = s
	var addon = ""
	let num = size - sSize
	for _ in 0..<num {addon.append(" ")}
	if right{return result + addon}
	return addon + result
  }
   func newPosition(position: Position, direction: Direction, magnitude: Int) -> Position
  {
    switch direction
    {
      case .South : return(Position(row: (position.row + magnitude), col: position.col))
      case .North : return(Position(row: (position.row - magnitude), col: position.col))
      case .East : return(Position(row: position.row, col: (position.col + magnitude)))
      case .West : return(Position(row: position.row, col: (position.col - magnitude)))
      case .SouthEast : return(Position(row: (position.row + magnitude), col: (position.col + magnitude)))
      case .SouthWest : return(Position(row: (position.row + magnitude), col: (position.col - magnitude)))
      case .NorthEast : return(Position(row: (position.row - magnitude), col: (position.col + magnitude)))
      case .NorthWest : return(Position(row: (position.row - magnitude), col: (position.col - magnitude)))
      //default: return position
    }
  }
  func isPositionEmpty(_ position: Position) -> Bool
  {
    return grid[position.row][position.col] == nil
  }
  func isDead(_ gameObject: gameObject) -> Bool
  {
    return gameObject.energy <= 0
  }
  func isValidPosition(_ position: Position) -> Bool
  {
    return (position.row < numberRows) && (position.col < numberCols) && (position.row >= 0) && (position.col >= 0)
  }
  func applyCost(_ GameObject: gameObject, amount: Int)
  {
    GameObject.useEnergy(amount: amount)
  }
  func isEnergyAvailable(_ go: gameObject, amount: Int) -> Bool
  {
    return go.energy >= amount
  }
  func getLegalSurroundingPositions(_ position: Position) -> [Position]
  {
    var arrayPosition: [Position] = []
    var legalPosition: Position
    for i in 0..<8
    {
      legalPosition = newPosition(position: position, direction: Direction(rawValue: i)!, magnitude: 1)
      if isValidPosition(legalPosition) == true
      {
        arrayPosition.append(legalPosition)
      }
    }
    return arrayPosition
  }
  func missleStrike(_ tank: Tank, _ destination: Position, _ power: Int, _ multiple: Int)
  {
    if isPositionEmpty(destination) == false
    {
      let target = grid[destination.row][destination.col]!
      var missleDamage = power * multiple
      if (target.objectType == .Tank)
      {
        let targetAsTank = target as! Tank
        missleDamage = missleDamage - targetAsTank.shields
      }
      let currentEnergy = target.energy
      target.useEnergy(amount: missleDamage)
      if (isDead(target) == true) && (target.objectType == .Tank)
      {
        grid[destination.row][destination.col] = nil
        tank.addEnergy(amount: (currentEnergy / Constants.missleStrikeEnergyTransferFraction))
      }
    }
  }
  func findGameObjectsWithinRange(_ position: Position, range: Int) -> [Position]
  {
    var posArray: [Position] = []
    var checkPosition: Position
    for i in 0..<range
    {
      for e in 0..<8
      {
        checkPosition = newPosition(position: position, direction: Direction(rawValue: e)!, magnitude: (i + 1))
        if (isValidPosition(checkPosition) == true)
        {
          if (grid[checkPosition.row][checkPosition.col] != nil)
          {
            posArray.append(checkPosition)
          }
        }
      }
    }
    return posArray
  }
  func findAllGameObjects() -> [gameObject]
  {
    var objects: [gameObject] = []
    var objectCheck: gameObject?
    for i in 0..<numberCols
    {
      for e in 0..<numberRows
      {
        objectCheck = grid[e][i]
        if (objectCheck != nil)
        {
          if (isDead(objectCheck!) != true)
          {
            objects.append(objectCheck!)
          }
        }
      }
    }
    return objects
  }
  func findAllTanks() -> [Tank]
  {
    let objects = findAllGameObjects()
    var tankCheck: [Tank] = []
    for i in objects
    {
      if (i.objectType == .Tank)
      {
        tankCheck.append(i as! Tank)
      }
    }
    return tankCheck
  }
  /*func findAllRovers() -> [Rover]
  {
    let objects = findAllGameObjects()
    var roverCheck: [Rover] = []
    for i in objects
    {
      if (i.objectType == .Rover)
      {
        roverCheck.append(i as! Rover)
      }
    }
    return roverCheck
  }*/
  func findWinner() -> Tank?
  {
    let winCheck: [Tank] = findAllTanks()
    if (winCheck.count == 1)
    {
      return winCheck[0]
    }
    else
    {
      return nil
    }
  }
}
