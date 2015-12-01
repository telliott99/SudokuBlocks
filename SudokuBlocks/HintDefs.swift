import Cocoa

func colorForHintType(t: HintType) -> NSColor {
    switch  t {
    case .one:  return blue
    case .two: return red
    case .three: return plum
    }
}

func == (lhs: Hint, rhs: Hint) -> Bool {
    if lhs.key != rhs.key { return false }
    if lhs.iSet != rhs.iSet { return false }
    return true
}

func < (lhs: Hint, rhs: Hint) -> Bool {
    if lhs.hintType != rhs.hintType {
        if lhs.hintType == .one {
            return true
        }
        else {
            if lhs.hintType == .two {
                if rhs.hintType == .one {
                    return false
                }
                else {
                    return true
                }
            }
            return false
        }
    }
    let oka = orderedKeys
    return oka.indexOf(lhs.key) < oka.indexOf(rhs.key)
}

typealias KeyArray = [String]

struct Hint: CustomStringConvertible, Hashable, Equatable {
    let key: String
    let iSet: IntSet
    let keyArray: [String]
    let hintType: HintType
    var description: String {
        get {
            let sortedISet = Array(iSet).sort()
            // return "\(kp):\n\(k) = \(sortedISet)"
            return "\(key) -> \(sortedISet), type \(self.hintType)"
        }
    }
    
    var hashValue: Int {
        get {
            let ka = orderedKeys
            var n = ka.indexOf(key)! * 10
            switch hintType {
            case .one:  n = 1
            case .two:  n += 2
            case .three:  n += 3
            }
            return n
       }
    }
}
