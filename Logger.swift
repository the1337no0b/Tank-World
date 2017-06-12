struct Logger: CustomStringConvertible {
  var log: String = ""
  mutating func addLog(_ GOType: gameObject, _ message: String) {
    log += "\(GOType): \(message)\n"
  }
  mutating func clearLog()
  {
    log = ""
  }
  var description: String {
    return "\(log)"
  }
}
