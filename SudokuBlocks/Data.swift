/*
A Sudoku board is represented as
a Dictionary of String:Set<Int>
e.g. D["A1"] -> {1,2,3}
dataD

The advantage of using a set to hold the data:
s.remove(1) is only in set
s.contains(1) is in both array and set

init syntax:
s = Set(1..<10) or 
s = Set([1,2,3])

When necessary to convert to array:
a = Array(s).sort()
or
Array(s).sortInPlace()
*/

typealias DataSet = [String:Set<Int>]
var dataD = DataSet()

let validChars = Set("0123456789.".characters)

func getCurrentData() -> DataSet {
    if dataD.isEmpty {
        dataD = constructZeroedDataDict()
    }
    return dataD
}

func constructZeroedDataDict() -> DataSet {
    // mostly, we will count starting from 1
    // the cells are 1..<10
    
    var D = DataSet()
    for key in orderedKeyArray() {
        D[key] = Set(1..<10)
    }
    return D
}

func constructNewPuzzle(s: String) -> DataSet? {
    let index = s.characters.startIndex
    dataD = constructZeroedDataDict()
    
    for (i,key) in orderedKeyArray().enumerate() {
        // data from the input string
        let v = s.characters[index.advancedBy(i)]
        
        // we accept "." or "0"
        // the Set<Int> is already good in this case
        if (".0".characters.contains(v)) { continue }
        
        // attempt conversion
        let n = Int(String(v))
        assert ((n != nil),
            "int conversion for \(v) at index \(i) failed.")
        
        // in the proper range
        let R = 1..<10
        guard ( R.contains(n!) ) else {
            Swift.print("invalid digit in new puzzle:  \(v)")
            return nil
        }
        // data storage for this cell of the puzzle
        dataD[key] = Set([n!])
    }
    return dataD
}
