import Foundation

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
            return false
        }
    }
    let oka = orderedKeyArray()
    return oka.indexOf(lhs.k) < oka.indexOf(rhs.k)
}

func == (lhs: KeyPair, rhs: KeyPair) -> Bool {
    if lhs.k1 != rhs.k1 { return false }
    if lhs.k2 != rhs.k2 { return false }
    return true
}

struct Hint: CustomStringConvertible, Hashable, Equatable {
    var k: String
    var iSet: IntSet
    var kp: KeyPair
    var t: HintType
    init(key: String, value: IntSet, keyPair: KeyPair, hintType: HintType) {
        k = key
        iSet = value
        kp = keyPair
        t = hintType
    }
    var description: String {
        get {
            let sortedISet = Array(iSet).sort()
            // return "\(kp):\n\(k) = \(sortedISet)"
            return "\(k) -> \(sortedISet)"
        }
    }
    var hashValue: Int {
        get {
            let kA = orderedKeyArray()
            return kA.indexOf(k)! * 10 + iSet.first!
        }
    }
}

struct KeyPair: CustomStringConvertible {
    var k1, k2: String
    init(first: String, second: String) {
        k1 = first
        k2 = second
    }
    var description: String {
        get {
            return "\(k1) and \(k2)"
        }
    }
}
