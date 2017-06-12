class Rover: gameObject
{
  let direction: Direction?
  init(row: Int, col: Int, energy: Int, direction: Direction? = nil)
  {
    self.direction = direction
    super.init(row: row, col: col, objectType: .Rover, name: "Rover", energy: energy, id: "ROVER")
  }
}
