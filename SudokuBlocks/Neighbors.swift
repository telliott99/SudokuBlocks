import Foundation

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



func arrayForKey(key: String, arrayOfArrays: [[String]]) -> [String]? {
    for arr in arrayOfArrays {
        if arr.contains(key) {
            var sub = Set(arr)
            sub.remove(key)
            return Array(sub).sort()
        }
    }
    return nil
}

func sameBoxForKey(key: String) -> [String] {
    let box = arrayForKey(key, arrayOfArrays: boxes)
    return box!
}


/*
not as stupid as it looks
only took a minute with global replace in TextMate
solved problems with logic and instantiation
*/

let rows = [
    ["A1","A2","A3","A4","A5","A6","A7","A8","A9"],
    ["B1","B2","B3","B4","B5","B6","B7","B8","B9"],
    ["C1","C2","C3","C4","C5","C6","C7","C8","C9"],
    ["D1","D2","D3","D4","D5","D6","D7","D8","D9"],
    ["E1","E2","E3","E4","E5","E6","E7","E8","E9"],
    ["F1","F2","F3","F4","F5","F6","F7","F8","F9"],
    ["G1","G2","G3","G4","G5","G6","G7","G8","G9"],
    ["H1","H2","H3","H4","H5","H6","H7","H8","H9"],
    ["I1","I2","I3","I4","I5","I6","I7","I8","I9"] ]

func sameRowForKey(key: String) -> [String] {
    let row = arrayForKey(key, arrayOfArrays: rows)
    return row!
}

let cols = [
    ["A1","B1","C1","D1","E1","F1","G1","H1","I1"],
    ["A2","B2","C2","D2","E2","F2","G2","H2","I2"],
    ["A3","B3","C3","D3","E3","F3","G3","H3","I3"],
    ["A4","B4","C4","D4","E4","F4","G4","H4","I4"],
    ["A5","B5","C5","D5","E5","F5","G5","H5","I5"],
    ["A6","B6","C6","D6","E6","F6","G6","H6","I6"],
    ["A7","B7","C7","D7","E7","F7","G7","H7","I7"],
    ["A8","B8","C8","D8","E8","F8","G8","H8","I8"],
    ["A9","B9","C9","D9","E9","F9","G9","H9","I9"] ]

func sameColForKey(key: String) -> [String] {
    let col = arrayForKey(key, arrayOfArrays: cols)
    return col!
}

func neighborsForKey(key: String) -> [String] {
    var a = sameRowForKey(key)
    a.appendContentsOf(sameColForKey(key))
    a.appendContentsOf(sameBoxForKey(key))
    
    // no duplicates
    a = Array(Set(a)).sort()
    return a
}



/*

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

/*
proposed replacement:

func makeRows() -> [[String]] {
Swift.print("makeRows")
let R = 1..<10
let dg = R.map( { String($0) } )
var rows = [[String]]()
for c in letters.characters {
let s = dg.map( { String(c) + $0 } )
rows.append(s)
}
Swift.print(rows)
return rows
}



func sameRowForKey(key: String) -> [String] {
let r = key.characters.first!
for row in rows {
if row[0].characters.first! == r {
var s = Set(row)
s.remove(key)
return Array(s).sort()
}
assert(true, "error in setting up rows")
}
return []
}

//=============================

func makeCols() -> [[String]] {
let C = ["A","B","C","D","E","F","G","H","I"]
let R = 1..<10
let dg = R.map( { String($0) } )
var cols = [[String]]()
for c in C {
let s = dg.map( { c + $0 } )
cols.append(s)
}
return cols
}

let cols = makeRows()

func sameColForKey(key: String) -> [String] {
let c = key.characters.last!
for col in cols {
if col[0].characters.last! == c {
var s = Set(col)
s.remove(key)
return Array(s).sort()
}
assert(true, "error in setting up cols")
}
return []
}

*/


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

*/