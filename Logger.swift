struct Logger: CustomStringConvertible {
  var log: String = ""
  let name: String
  mutating func addLog(_ GOType: gameObject, _ message: String) {
    log += "\(GOType): \(message)\n"
  }
  mutating func clearLog()
  {
    log = ""
  }
  init(name: String)
  {
    self.name = name
  }
  var description: String {
    return "\(log)"
  }
}
