struct logger: CustomStringConvertible {
  var log: String = ""

  mutating func addLog(gameObject: gameObject, message: String) {
    log += "\(gameObject): \(message)\n"
  }
  var description: String {
    return "\(log)"
  }
}
