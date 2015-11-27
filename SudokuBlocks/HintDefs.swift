import Cocoa

func colorForHintType(t: HintType) -> NSColor {
    switch  t {
    case .one:  return blue
    case .two: return red
    case .three: return clover
    }
}


/*
convenience method
count how many times
a particular IntSet is found in an array
*/

var hintList = [Hint]()

// count the number of elements of any Equatable Type
extension Array {
    func elementCount<T: Equatable> (input: T) -> Int {
        var count = 0
        for el in self {
            if el as! T == input {
                count += 1
            }
        }
        return count
    }
}


func == (lhs: Hint, rhs: Hint) -> Bool {
    if lhs.k != rhs.k { return false }
    if lhs.iSet != rhs.iSet { return false }
    return true
}

func < (lhs: Hint, rhs: Hint) -> Bool {
    if lhs.t != rhs.t {
        if lhs.t == .one {
            return true
        }
        else {
            if lhs.t == .two {
                if rhs.t == .one {
                    return false
                }
                else {
                    return true
                }
            }
            return false
        }
    }
    let oka = orderedKeyArray()
    return oka.indexOf(lhs.k) < oka.indexOf(rhs.k)
}

typealias KeyArray = [String]

struct Hint: CustomStringConvertible, Hashable, Equatable {
    var k: String
    var iSet: IntSet
    var ka: [String]
    var t: HintType
    init(key: String, value: IntSet,
         keyArray: KeyArray, hintType: HintType) {
        k = key
        iSet = value
        ka = keyArray
        t = hintType
    }
    var description: String {
        get {
            let sortedISet = Array(iSet).sort()
            // return "\(kp):\n\(k) = \(sortedISet)"
            return "\(k) -> \(sortedISet), type \(self.t)"
        }
    }
    var hashValue: Int {
        get {
            let kA = orderedKeyArray()
            return kA.indexOf(k)! * 10 + iSet.first!
        }
    }
}
