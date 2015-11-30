import Foundation


let validChars = Set("0123456789.".characters)

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
            return self.stringRepresentation()
        }
    }
}

/*
consider changing text representation to
OK since space is not a valid character

874 162 395
125 379 864
396 854 172
748 291 653
261 735 489
539 486 217

687 523 941
453 9187 26
912 647 538

*/

extension Puzzle {
    func stringRepresentation() -> String {
        var arr = [String]()
        for key in self.dataD.keys.sort() {
            let data = Array(dataD[key]!)
            if data.count > 1 {
                arr.append("0")
            }
            else {
                arr.append(String(data[0]))
            }
        }
        let s = arr.joinWithSeparator("")
        // could have done this by enumerating, above
        // just exercising my String extension
        
        /*
        let arr2 = s.divide(9)
        return arr2.joinWithSeparator("\n")
        */
        var ret = [String]()
        for (i,chunk) in s.divide(3).enumerate() {
            if i != 0 {
                if (i % 3 == 0) {
                    ret.append("\n")
                }
                else {
                    ret.append(" ")
                }
            }

            if i != 0 && (i % 9 == 0) {
                ret.append("\n")
            }

            ret.append(chunk)
        }
        return ret.joinWithSeparator("")
    }
    
    func getIntSets() -> [IntSet] {
        var result = [IntSet]()
        for key in orderedKeyArray() {
            let value = self.dataD[key]!
            result.append(value)
        }
        return result
    }
}

func getIntSetsForKeyArray(group: [String]) -> [IntSet] {
    var result = [IntSet]()
    for key in group {
        let value = currentPuzzle.dataD[key]!
        result.append(value)
    }
    return result
}



