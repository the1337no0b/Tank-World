//complete
struct MessageCenter
{
  static var storedMessages: [String: String] = [:]
  static func receivedMessage(Id: String) -> String?
  {
    var returnMessage: String?
    var found = false
    for (id, message) in storedMessages
    {
      if (Id == id)
      {
        returnMessage = message
        found = true
      }
    }
    if found == true
    {
      return returnMessage
    }
    else
    {
      return nil
    }
  }
  static func sendMessage(Id: String, message: String)
  {
    storedMessages[Id] = message
  }
}
