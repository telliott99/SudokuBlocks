import Foundation

func isLegalMove(key: String, st: Set<Int>) -> Bool {
    // it is proposed to set dataD[key] = st
    // check for conflicts
    // for now, don't be fancy
    if st.count > 1 { return true }
    let n = st.first!
    
    // just check for another filled square
    let a = neighborsForKey(key)
    for k in a {
        let tmp = dataD[k]!
        if tmp.count == 1 {
            if Array(tmp).first! == n {
                return false
            }
        }
    }
    return true
}

func getAllFilledSquares()-> [String] {
    var a = [String]()
    for key in dataD.keys {
        if dataD[key]!.count == 1 {
            a.append(key)
        }
    }
    return a
}
