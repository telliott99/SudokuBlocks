import Foundation

/*
an array of moves
move -> value, was it removed (true) or not,
and an array of the keys for the affected squares

we have two kinds of moves
simple insertion or deletion of a value
we want to save one value, and an array of Strings
the keys for the squares we changed

another type of move uses the command key
choose one single value to remain and delete the rest
we will call this move type a substitution

the moveL can contain only values all of the same type
to deal with this we add [Int] to the move
which *may* be empty

we only use it if MoveType is a substitution
*/

var moveL = [(Int, MoveType, [String], Set<Int>)] ()

func undoLastMove() {
    if moveL.count == 0 {
        return
    }
    
    let m = moveL.removeLast()
    Swift.print("undo \(m)")
    let (n, move, string_arr, int_set) = m
    var tmp: Set<Int>
    
    switch move {
        case .deletion:
        // reversing a deletion
        for key in string_arr {
            tmp = dataD[key]!
            tmp.insert(n)
            dataD[key] = tmp
        }
        
        case .insertion:
        // reversing an insertion
        for key in string_arr {
            tmp = dataD[key]!
            tmp.remove(n)
            dataD[key] = tmp
        }
        
        case .substitution:
        let key = string_arr.first!
        dataD[key] = int_set
    }
    refreshScreen()
}
