struct Position
{
  let row: Int
  let col: Int
  let rowcol: [Int]
  init (row: Int, col: Int)
  {
    self.row = row
    self.col = col
    self.rowcol = [row, col]
  }
}
