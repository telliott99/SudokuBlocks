import Cocoa

func calculateHintsForThisPosition() {
    if let hints = getTypeOneHints() {
        hintList += Array(hints)
    }
    if let hints = getTypeTwoHints() {
        hintList += Array(hints)
    }
    if let hints = getTypeThreeHints() {
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

func getHintCount() -> (Int,Int,Int) {
    // get number of hints of each type
    let hL = hintList
    var m = 0
    var n = 0
    var o = 0
    for h in hL {
        if h.t == .one {
            m += 1
        }
        if h.t == .two {
            n += 1
        }
        if h.t == .three {
            o += 1
        }
    }
    // Swift.print("hints: \(m) \(n)o) \(")
    return (m,n,o)
}

func removeDuplicateHints(hintList: [Hint]) -> [Hint] {
    var a = Set<String>()
    var ret = [Hint]()
    // try to save type 3's
    for h in hintList.reverse() {
        let key = h.k
        if a.contains(key) {
            continue
        }
        a.insert(key)
        ret.append(h)
    }
    return ret
}

func displayHints() {
    let appDelegate = NSApplication.sharedApplication().delegate as! AppDelegate
    let wc = appDelegate.mainWindowController
    
    if hintActive {
        outlineHintSquares()
        let (c1,c2,c3) = getHintCount()
        
        if wc != nil {
            wc!.label1.stringValue = String(c1)
            wc!.label2.stringValue = String(c2)
            wc!.label3.stringValue = String(c3)
       }
    }
        
    else {
        if wc != nil {
            wc!.label1.stringValue = String("")
            wc!.label2.stringValue = String("")
            wc!.label3.stringValue = String("")
        }
    }
    
}


