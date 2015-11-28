import Foundation

/*
major refactoring
not implemented yet
*/

struct Puzzle {
    let title: String
    let initialText: String
    var dataD: [String:Set<Int>]
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
