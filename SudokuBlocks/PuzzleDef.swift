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
    func getCurrentStateAsString() -> String {
        var arr = [String]()
        for (i,key) in dataD.keys.sort().enumerate() {
            if i != 0 {
                if (i % 9 == 0) {
                    arr.append("\n")
                }
            }
            let data = Array(dataD[key]!)
            if data.count > 1 {
                arr.append("0")
            }
            else {
                arr.append(String(data[0]))
            }
        }
        let s = arr.joinWithSeparator("")
        return s
    }
}
