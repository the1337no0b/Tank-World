class Tank: gameObject
{
  var shield = 0
  let messageID = "12345" //Change numbers later
	func launchMissile(energyInput: Int, designatedTarget: [Int])
  {
    loseEnergy(energyLost: energyInput)
    /*The tank object sends a command to the tankworld class with a
    energy int and a position. It calls a method that check the position
    and surrounding positons for gameObjects and subtracts the energy specified from them.*/
	}

	func jump(distance: Int, direction: Direction)
  {
      /*Calls the move command and gives it the distance
      and direction to move*/
	}
  func setShield(energyInput: Int)
  {
    /*Sets the shield to the energy given*/
    loseEnergy(energyLost: energyInput)
    shield = 8 * energyInput
  }
  func RunRadar(distance: Int) -> ([gameObject.energy], [gameObject.id], [gameObject.Position])
  {
    /*Calls RadarResult with the position of the tank and a specified
    distance then returns an array of the found fame objects*/
  }
  func SendMessage(message: String)
  {
    /*Calls the MessageCenter and gives it a tuple containing
    the messageId and the message*/
  }
  func RecieveMessage(id: String)
  {
    /*Calls the MessageCenter and checks if it contains
    a message with a given id*/
  }
  func DropMine(energyInput: Int, direction: Direction)
  {
    /*Creates a mine game object at the space adjacent to the
    tank in the specified direction*/
  }
  func DropRover(energyInput: Int, direction: Direction, roverDir: Direction, Random: Bool)
  {
    /* Creates a rover game object at the space adjacent
    to the tank in the specified direction and then checks
    to see if the random bool is true. If it is the rover is set
    to move randomly. Otherwise it sets the rover to move in the
    specified direction*/
  }
}
