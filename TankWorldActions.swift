extension TankWorld
{
  func actionSendMessage(tank: Tank, sendMessageAction: SendMessageAction)
  {
    if isDead(tank) {return}
    logger.addLog(tank, "Sending Message \(sendMessageAction)")
    if !isEnergyAvailable(tank, amount: Constants.costOfSendingMessage)
    {
      logger.addLog(tank, "Insufficient energy to send message")
      return
    }

    applyCost(tank, amount: Constants.costOfSendingMessage)
    MessageCenter.sendMessage(Id: sendMessageAction.id, message: sendMessageAction.message)
  }
  func actionReceiveMessage(tank: Tank, receiveMessageAction: ReceiveMessageAction)
  {
    if isDead(tank) {return}
    logger.addLog(tank, "Recieving Message \(receiveMessageAction)")

    if !isEnergyAvailable(tank, amount: Constants.costOfReceivingMessage)
    {
      logger.addLog(tank, "Insufficient energy to receive message")
      return
    }

    applyCost(tank, amount: Constants.costOfReceivingMessage)
    let message = MessageCenter.receivedMessage(Id: receiveMessageAction.id)
    tank.setReceivedMessage(receivedMessage: message)
  }
  func actionSetShields(tank: Tank, setShieldsAction: SetShieldsAction)
  {
    if isDead(tank) {return}
    logger.addLog(tank, "Setting Shields \(setShieldsAction)")

    if !isEnergyAvailable(tank, amount: setShieldsAction.shield)
    {
      logger.addLog(tank, "Insufficient energy to set shields")
      return
    }

    applyCost(tank, amount: setShieldsAction.shield)
    tank.setShields(amount: setShieldsAction.shield * Constants.shieldPowerMultiple)
  }
  func actionFireMissle(tank: Tank, fireMissleAction: FireMissleAction)
  {
    if isDead(tank) {return}
    logger.addLog(tank, "Firing Missle \(fireMissleAction)")

    if !isEnergyAvailable(tank, amount: fireMissleAction.power)
    {
      logger.addLog(tank, "Insufficient energy to fire missle")
      return
    }
    if !isValidPosition(fireMissleAction.destination)
    {
      logger.addLog(tank, "Invalid destination for missle")
      return
    }
    applyCost(tank, amount: fireMissleAction.power)
    missleStrike(tank, fireMissleAction.destination, fireMissleAction.power, Constants.missleStrikeMultiple)
    let collateralPosition = getLegalSurroundingPositions(fireMissleAction.destination)
    for i in collateralPosition
    {
      missleStrike(tank, i, fireMissleAction.power, Constants.missleStrikeMultipleCollateral)
    }
  }
  func actionMove(tank: Tank, moveAction: MoveAction)
  {
    if isDead(tank) {return}
    logger.addLog(tank, "Moving \(moveAction)")

    if !isEnergyAvailable(tank, amount: Constants.costOfMovingTankPerUnitDistance[moveAction.distance - 1])
    {
      logger.addLog(tank, "Insufficient energy to move")
      return
    }
    let newPos = newPosition(position: tank.position, direction: moveAction.direction, magnitude: moveAction.distance)
    if !isValidPosition(newPos)
    {
      logger.addLog(tank, "Invalid destination to move")
      return
    }
    let posCheck = grid[newPos.row][newPos.col]!
    if (posCheck.objectType == .Tank)
    {
      logger.addLog(tank, "Invalid destination to move")
      return
    }
    applyCost(tank, amount: Constants.costOfMovingTankPerUnitDistance[moveAction.distance - 1])
    grid[newPos.row][newPos.col] = tank
    tank.setPosition(newPosition: newPos)
    if (posCheck.objectType == .Mine) || (posCheck.objectType == .Rover)
    {
      tank.useEnergy(amount: (posCheck.energy * Constants.mineStrikeMultiple))
    }
  }
  func actionRunRadar(tank: Tank, runRadarAction: RunRadarAction)
  {
    if isDead(tank) {return}
    logger.addLog(tank, "Running Radar \(runRadarAction)")

    if !isEnergyAvailable(tank, amount: Constants.costOfRadarByUnitsDistance[runRadarAction.range - 1])
    {
      logger.addLog(tank, "Insufficient energy to run radar")
      return
    }
    if (runRadarAction.range >= Constants.costOfRadarByUnitsDistance.count)
    {
      logger.addLog(tank, "Radar range too large")
      return
    }
    applyCost(tank, amount: Constants.costOfRadarByUnitsDistance[runRadarAction.range - 1])
    let positionResult = findGameObjectsWithinRange(tank.position, range: runRadarAction.range)
    var radarResults: [RadarResult]
    var go: gameObject
    for i in positionResult
    {
      go = grid[i.row][i.col]!
      var radar = RadarResult(go: go)
      radarResults.append(radar)
    }
    tank.setRadarResult(radarResults: radarResults)
  }
}
