struct logger: CustomStringConvertible {
  var log: String = ""

  mutating func addLog(GOType: GameObjectType, message: String) {
    log += "\(GOType): \(message)\n"
  }
  var description: String {
    return "\(log)"
  }
}
