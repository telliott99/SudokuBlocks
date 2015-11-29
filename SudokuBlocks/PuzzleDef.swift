import Foundation

/*
major refactoring
*/

var currentPuzzle = Puzzle(
    title: String(),
    text: String(),
    start:DataSet(),
    dataD:DataSet() )

struct Puzzle {
    let title: String
    let text: String
    let start: DataSet
    var dataD: DataSet
    var description: String {
        get {
            return getCurrentStateAsString()
        }
    }
}
