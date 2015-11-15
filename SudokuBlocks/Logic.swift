import Cocoa

// finding the "neighbors" for a key
// same row, col or 3 x 3 box

// crude, but effective

let boxes = [
    ["A1","A2","A3","B1","B2","B3","C1","C2", "C3"],
    ["A4","A5","A6","B4","B5","B6","C4","C5", "C6"],
    ["A7","A8","A9","B7","B8","B9","C7","C8", "C9"],
    ["D1","D2","D3","E1","E2","E3","F1","F2", "F3"],
    ["D4","D5","D6","E4","E5","E6","F4","F5", "F6"],
    ["D7","D8","D9","E7","E8","E9","F7","F8", "F9"],
    ["G1","G2","G3","H1","H2","H3","I1","I2", "I3"],
    ["G4","G5","G6","H4","H5","H6","I4","I5", "I6"],
    ["G7","G8","G9","H7","H8","H9","I7","I8", "I9"] ]

func sameBoxForKey(key: String) -> [String] {
    var a: [String] = []
    for bx in boxes {
        if bx.contains(key) {
            a = bx
            break
        }
    }
    var sub = Set(a)
    sub.remove(key)
    return Array(sub).sort()
}

func sameRowForKey(key: String) -> [String] {
    let r = key.characters.first!
    var a = [String]()
    for d in "123456789".characters {
        a.append(String([r,d]))
    }
    var s = Set(a)
    s.remove(key)
    return Array(s).sort()
}

func sameColForKey(key: String) -> [String] {
    let d = key.characters.last!
    var a = [String]()
    for l in "ABCDEFGHI".characters {
        a.append(String([l,d]))
    }
    var s = Set(a)
    s.remove(key)
    return Array(s).sort()
}

func neighborsForKey(key: String) -> [String] {
    var a = sameRowForKey(key)
    a.appendContentsOf(sameColForKey(key))
    a.appendContentsOf(sameBoxForKey(key))
    
    // no duplicates
    a = Array(Set(a)).sort()
    return a
}

func showNeighbors() {
    let D = dataD.keys.sort()
    Swift.print(D)
    for key in D {
        Swift.print(key)
        Swift.print(neighborsForKey(key).sort())
        Swift.print("")
    }
}

func isLegalMove(key: String, st: Set<Int>) -> Bool {
    // it is proposed to set dataD[key] = st
    // check for conflicts
    // for now, don't be fancy
    if (st.count > 1) { return true }
    let n = st.first!
    
    // just check for another filled square
    let a = neighborsForKey(key)
    for k in a {
        let tmp = dataD[k]!
        if (tmp.count == 1) {
            if (Array(tmp).first! == n) {
                return false
            }
        }
    }
    return true
}

