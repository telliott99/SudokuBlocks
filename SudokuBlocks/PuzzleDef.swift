import Foundation

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
text representation on screen
OK since space is not a valid character
(leave out spaces or extra lines when writing to disk)

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
    func dataAsOneLineString() -> String {
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
        return arr.joinWithSeparator("")
    }
    
    func stringRepresentation() -> String {
        // could have done this by enumerating, above
        // just exercising my String extension
        let s = self.dataAsOneLineString()
        var ret = [String]()
        for (i,chunk) in s.divideStringIntoChunks(chunkSize: 3).enumerate() {
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
    
    // no extra spaces for disk storage
    func fileRepresentation() -> String {
        let s = self.dataAsOneLineString()
        var ret = [String]()
        for (i,chunk) in s.divideStringIntoChunks(chunkSize: 9).enumerate() {
            if i != 0 {
                ret.append("\n")
            }
            ret.append(chunk)
        }
        return ret.joinWithSeparator("")
    }
    
    func getAllIntSets() -> [IntSet] {
        var result = [IntSet]()
        for key in orderedKeys {
            let value = self.dataD[key]!
            result.append(value)
        }
        return result
    }
    
    func getIntSetsForKeyArray(group: [String]) -> [IntSet] {
        var result = [IntSet]()
        for key in group {
            let value = currentPuzzle.dataD[key]!
            result.append(value)
        }
        return result
    }

    func keyForValue(group: [String], value: IntSet, dataD: DataSet) -> String? {
        for key in group {
            if dataD[key]! == value {
                return key
            }
        }
        return nil
    }
}



