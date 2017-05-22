//complete

struct MessageCenter
{
  var storedMessages: [String: String]
  func receivedMessage(id: String) -> String?
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
  mutating func sendMessage(id: String, message: String)
  {
    storedMessages[id] = message
  }
}
