// deal with puzzle data in the form of Strings


import Cocoa

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


