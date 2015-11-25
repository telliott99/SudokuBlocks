import Foundation

func calculateHintsForThisPosition() {
    if let hints = getTypeOneHints() {
        hintList += Array(hints)
    }
    if let hints = getTypeTwoHints() {
        hintList += Array(hints)
    }
    if hintList.count == 0 {
        runAlert("no hints right now")
    }
    
    hintList = removeDuplicateHints(hintList)
    hintList.sortInPlace( { $0 < $1 } )
    for h in hintList {
        Swift.print(h)
    }
}

func setHintStatus(flag: Bool) {
    hintActive = flag
    selectedHint = 0
}

func getHintCount() -> (Int,Int) {
    // get number of hints of each type
    let hL = hintList
    var n = hL.count
    var m = 0
    for h in hL {
        if h.t == .one {
            m += 1
        }
    }
    n -= m
    // Swift.print("hints: \(m) \(n)")
    return (m,n)
}

func removeDuplicateHints(hintList: [Hint]) -> [Hint] {
    var a = Set<String>()
    var ret = [Hint]()
    for h in hintList {
        let key = h.k
        if a.contains(key) {
            continue
        }
        a.insert(key)
        ret.append(h)
    }
    return ret
}



