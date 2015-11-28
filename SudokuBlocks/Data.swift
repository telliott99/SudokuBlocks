/*
A Sudoku board is represented as
a Dictionary of String:Set<Int>
e.g. D["A1"] = {1,2,3}
dataD

The advantage of using a set to hold the data:
s.remove(1) is only for sets
s.contains(1) is for both arrays and sets

init syntax:
s = Set(1..<10) or 
s = Set([1,2,3])

When necessary to convert to array:
a = Array(s).sort()
or
Array(s).sortInPlace()
*/

typealias IntSet = Set<Int>
typealias DataSet = [String:IntSet]

var initialState = DataSet()

let validChars = Set("0123456789.".characters)

func constructZeroedDataDict() -> DataSet {
    // mostly, we will count starting from 1
    // the cells are [1,2,3,4,5,6,7,8,9] == 1..<10
    
    var D = DataSet()
    for key in orderedKeyArray() {
        D[key] = Set(1..<10)
    }
    return D
}

func getIntSetsForKeyArray(arr: [String]) -> [IntSet] {
    var result = [IntSet]()
    for key in arr {
        let value = currentPuzzle.dataD[key]!
        result.append(value)
        }
    return result
}


func convertStringToDataSet(s: String) -> DataSet? {
    let s2 = removeNewlinesFromPuzzleString(s)
    let sc = s2.characters
    let index = sc.startIndex
    var dataD = constructZeroedDataDict()

    // want to enumerate but we need an "Index", it's awkward
    
    for (i,key) in orderedKeyArray().enumerate() {
        // data from the input string
        let v = sc[index.advancedBy(i)]
        
        // we accept "." or "0"
        // the Set<Int> is already good in this case
        if (".0".characters.contains(v)) { continue }
        
        // attempt conversion to Int
        let m = Int(String(v))
        assert ((m != nil),
            "int conversion for \(v) at index \(i) failed.")
        
        let n = m!
        
        // check for the proper range
        let R = 1..<10
        guard ( R.contains(n) ) else {
            Swift.print("invalid digit in new puzzle:  \(v)")
            return nil
        }
        // data storage for this cell of the puzzle
        dataD[key] = Set([n])
    }
    
    initialState = dataD
    return dataD
}
