class Tank: gameObject
{
  private (set) var shields: Int = 0
  private var radarResults: [RadarResult]?
  private var receivedMessage: String?
  private (set) var preActions = [Actions : PreAction]()
  private (set) var postActions = [Actions : PostAction]()
  private let initialInstructions: String?

  init(row: Int, col: Int, name: String, energy: Int, id: String, instructions: String)
  {
    initialInstructions = instructions
    super.init(row: row, col: col, objectType: .Tank, name: name, energy: energy, id: id)
  }

  final func clearActions()
  {
    preActions = [Actions : PreAction]()
    postActions = [Actions : PostAction]()
  }

  final func recieveMessage(message: String?) {receivedMessage = message}

  func computePreActions()
  {

  }

  func computePostActions()
  {

  }
  final func addPreAction(preAction : PreAction)
  {
    preActions[preAction.action] = preAction
  }
  final func addPostAction(postAction: PostAction)
  {
    postActions[postAction.action] = postAction
  }
  final func setShields(amount: Int) {shields = amount}
  final func setRadarResult(radarResults: [RadarResult]!)
  {
    self.radarResults = radarResults
  }
  final func setReceivedMessage(recievedMessage: String!)
  {
    self.receivedMessage = receivedMessage
  }
}
