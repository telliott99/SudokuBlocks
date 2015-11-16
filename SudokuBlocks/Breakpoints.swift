import Foundation

import Foundation

/*
we represent a breakpoint
with a data structure that holds all the info
needed to revert to that point

we need the move list
we need the current dataD

do we need the original puzzle?
probably not
*/

var breakPointList = [Breakpoint]()

struct Breakpoint {
    var a = [Move]()
    var D = DataSet()
    init(arr: [Move], dict: DataSet) {
        a = arr
        D = dict
    }
}

func addNewBreakpoint() {
    let b = Breakpoint(arr: moveL, dict: dataD)
    breakPointList.append(b)
    // Swift.print("\(b)")
}

func restoreLastBreakpoint() {
    if breakPointList.count == 0 {
        return
    }
    let bp = breakPointList.removeLast()
    moveL = bp.a
    dataD = bp.D
    refreshScreen()
}




