enum Actions
{
  case SendMessage
  case ReceiveMessage
  case RunRadar
  case SetShields
  case DropMine
  case DropRover
  case FireMissle
  case Move
}
protocol Action: CustomStringConvertible
{
  var action: Actions {get}
  var description: String {get}
}
protocol PreAction: Action
{

}
protocol PostAction: Action
{

}
struct MoveAction: PostAction
{
  let action: Actions
  let distance: Int
  let direction: Direction
  var description: String
  {
      return "\(action) \(distance) \(direction)"
  }
  init(distance: Int, direction: Direction)
  {
    action = .Move
    self.distance = distance
    self.direction = direction
  }
}
struct SendMessageAction: PreAction
{
  let action: Actions
  let message: String
  let id: String
  var description: String
  {
    return "\(action) \(id) \(message)"
  }
  init(id: String, message: String)
  {
    self.message = message
    self.id = id
    action = .SendMessage
  }
}
struct ReceiveMessageAction: PreAction
{
  let action: Actions
  let id: String
  var description: String
  {
    return "\(action) \(id)"
  }
  init(id: String, message: String)
  {
    self.id = id
    action = .ReceiveMessage
  }
}
struct SetShieldsAction: PreAction
{
  let action: Actions
  let shield: Int
  var description: String
  {
    return "\(action) \(shield)"
  }
  init (shield: Int)
  {
    self.shield = shield
    action = .SetShields
  }
}
struct FireMissleAction: PostAction
{
  let action: Actions
  let power: Int
  let destination: Position
  var description: String
  {
    return "\(action) \(power) \(destination)"
  }
  init (power: Int, destination: Position)
  {
    self.power = power
    self.destination = destination
    action = .FireMissle
  }
}
struct RunRadarAction: PreAction
{
  let action: Actions
  let range: Int
  var description: String
  {
    return "\(action) \(range)"
  }
  init (range: Int)
  {
    self.range = range
    action = .RunRadar
  }
}
