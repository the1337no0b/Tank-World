struct RadarResult
{
  let position: Position
  let id: String
  let energy: Int
  init(go: gameObject)
  {
    self.position = go.position
    self.energy = go.energy
    self.id = go.id
  }
}
