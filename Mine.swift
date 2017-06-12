class Mine: gameObject
{
  init(row: Int, col: Int, energy: Int)
  {
    super.init(row: row, col: col, objectType: .Mine, name: "Mine", energy: energy, id: "MINE")
  }
}
