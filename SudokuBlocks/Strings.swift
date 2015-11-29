// deal with puzzle data in the form of Strings


import Cocoa

let letters = "ABCDEFGHI"
let letterArray = Array(arrayLiteral: letters)

let digits =  "123456789"
let digitArray = Array(arrayLiteral: digits)

var keyForCurrentPuzzle = ""

func orderedKeyArray() -> [String] {
    var kL = [String]()
    for l in letters.characters {
        for d in digits.characters {
            kL.append(String([l,d]))
        }
    }
    return kL
}

// given a group of keys and a value
// find the key with that value

func getKeyForValue(group: [String], value: IntSet, dataD: DataSet) -> String? {
    for key in group {
        if dataD[key]! == value {
            return key
        }
    }
    return nil
}

func validatedPuzzleString(s: String) -> String? {
    // let ws = NSCharacterSet.whitespaceAndNewlineCharacterSet()
    // doesn't work properly for \n
    
    var a = [Character]()
    for c in s.characters {
        if " \n".characters.contains(c) {
            continue
        }
        a.append(c)
    }
    
    if !(a.count == 81) {
        return nil
    }
    
    if !Set(a).isSubsetOf(validChars) {
        return nil
    }
    return String(a)
}

// returns true for success

func loadPuzzleDataFromString(title: String, s: String) -> Bool {
    let ns = validatedPuzzleString(s)
    if ns == nil {
        let _ = runAlert("something wrong with that one")
        Swift.print(s)
        Swift.print(ns)
        return false
    }
    
    let dataD = convertStringToDataSet(s)
    if dataD == nil { return false }
    
    currentPuzzle = Puzzle(
        title: title,
        text: s,
        start: dataD!,
        dataD: dataD! )
    
    refreshScreen()
    return true
}

func getCurrentStateAsString() -> String {
    var arr = [String]()
    let dataD = currentPuzzle.dataD
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
    // Swift.print(s)
    return s
}

func addNewlinesToPuzzleString(s: String) -> String {
    Swift.print("add newlines to \(s)")
    var current = s
    var ret = [String]()
    while current.characters.count > 0 {
        Swift.print("count \(current.characters.count)")
        let i = current.startIndex.advancedBy(9)
        let front = current.substringToIndex(i)
        Swift.print(front)
        ret.append(front)
        ret.append("\n")
        current = current.substringFromIndex(i)
    }
    return s
}

func removeNewlinesFromPuzzleString(s: String) -> String {
    let r = s.characters.split() {$0 == "\n"}.map{String($0)}
    return r.joinWithSeparator("")
}

