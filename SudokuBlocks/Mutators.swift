/* 
this file contains the two functions that modify the dataD
*after* a puzzle has been loaded
*/

import Foundation

let nullSet = Set<Int>()

// definition for reference:
// var moveL = [ (Int, MoveType, [String], Set<Int>) ] ()

// this function modifies the dataD

func respondToClick(key: String, point: NSPoint,
                    rect: CGRect, cmd: Bool) {
    let x = point.x - rect.origin.x
    let y = point.y - rect.origin.y
    let n = indexOfTinyRectForPoint(x, y:y) + 1
                        
    // Swift.print("\(key) \(point) \(rect) \(x) \(y) \(i)")
    var tmp = dataD[key]!
    
    // what should if the user clicks a filled square?
    if tmp.count == 1 {
        return
    }
    
    var m: MoveType
    if cmd {
        m = .substitution
        // for a substitution we save the old value as [Int]
        moveL.append( (n, m, [key], tmp) )
        tmp = Set([n])
    }
    
    else {
        tmp.remove(n)
        m = .deletion
        moveL.append( (n, m, [key], nullSet))
    }
    
    if (!(isLegalMove(key, st: tmp))) {
        runAlert("There appears to be a problem with that move.")
        return
    }
    dataD[key] = tmp
    refreshScreen()
    /* 

    decided not to auto-clean now
    applyConstraintsForFilledSquare(key)
    
    */
}

// this function modifies the dataD
func applyConstraintsForFilledSquare(key: String) {
    
    let st = dataD[key]!
    
    assert(!(st.count > 1),
        "Cannot apply constraints for: \(key) with multiple values!")
    
    assert ((st.count > 0),
        "Received empty set for key: \(key)")
    
    let n = st.first!   // since st is a set
    let a = neighborsForKey(key)
    
    let move: MoveType = .deletion
    
    // not every value will be modified
    // save the relevant keys
    var a2 = [String]()
    
    for key in a {
        var tmp = dataD[key]!
        if tmp.count > 1 && tmp.contains(n) {
            tmp.remove(n)
            dataD[key] = tmp
            a2.append(key)
        }
    }
    
    // now construct the move:
    if a2.count != 0 {
        moveL.append( (n, move, a2, nullSet ))
    }
    
}

func applyConstraintsForAllFilledSquares() {
    // decided to just go through the squares once..
    var a = [String]()
    for key in dataD.keys {
        if dataD[key]!.count == 1 {
            a.append(key)
        }
    }
    for key in a {
        applyConstraintsForFilledSquare(key)
    }
    refreshScreen()
}

