import Foundation

/*
implement detection of good next move

"twos":
square with key k has [1,2,3]
two neighbors each have [1,2]
hint is to show k and 3

*/

/*
convenience method
count how many times
a particular IntSet is found in an array
*/

var hintList = [Hint]()

extension Array {
    func elementCount (input: IntSet) -> Int {
        var count = 0
        for el in self {
            if el as! IntSet == input {
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

func == (lhs: KeyPair, rhs: KeyPair) -> Bool {
    if lhs.k1 != rhs.k1 { return false }
    if lhs.k2 != rhs.k2 { return false }
    return true
}

struct Hint: CustomStringConvertible, Hashable, Equatable {
    var k: String
    var iSet: IntSet
    var kp: KeyPair
    init(key: String, value: IntSet, keyPair: KeyPair) {
        k = key
        iSet = value
        kp = keyPair
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

// typealias IntSet = Set<Int>
// typealias DataSet = [String:IntSet]

var a = [IntSet]()



func findRepeatedTwos(neighbors: [String]) -> [KeyPair]? {
    let arr = getIntSetsForKeyArray(neighbors)

    // filter for 2 elements
    let twos = arr.filter( { $0.count == 2 } )
    
    var repeatsTwice = [IntSet]()
    for set in Set(twos) {
        if arr.elementCount(set) == 2 {
            repeatsTwice.append(set)
        }
    }
    
    // repeatsTwice contains IntSets that occur twice
    // now we need the corresponding keys, we return *both* keys
    
    var results = [KeyPair]()
    
    for set in repeatsTwice {
        var t = [String]()
        for key in neighbors {
            if set == dataD[key] {
                t.append(key)
            }
        }
        results.append(KeyPair(first:t[0], second:t[1]))
    }
    if results.count == 0 {
        return nil
    }
    return results
}

/*
Type One situation, we have

neighbors:  [ {1,2}, .. {1,2}, .. {1,2,3} ]
so the last one must be {3}
ss
or
neighbors:  [ {1,2}, .. {1,2}, .. {1,3} ]
so the last one cannot be {1}

*/

func getTypeOneHints() -> Set<Hint>? {
    // return an array of Hint objects if we find any
    var hints = [Hint]()
    
    for neighbors in boxes + rows + cols {
        if let results = findRepeatedTwos(neighbors) {
            
            for kp in results {
                // a KeyPair has __ k1 and k2
                let repeatedIntSet = dataD[kp.k1]!
                
                for key in neighbors {
                    if key == kp.k1 || key == kp.k2 {
                        continue
                    }
                    
                    let set = Set(dataD[key]!)
                    
                    // if both values are present
                    if repeatedIntSet.isSubsetOf(set) {
                        let iSet = set.subtract(repeatedIntSet)
                        let h = Hint(key: key, value: iSet, keyPair: kp)
                        hints.append(h)
                    }
                    
                    // if only one of the two values is present
                    // n is an Int
                    
                    for n in repeatedIntSet {
                        if set.contains(n) {
                            let intersection = set.intersect(repeatedIntSet)
                            let iSet = set.subtract(intersection)
                            let h = Hint(key: key, value: iSet, keyPair: kp)
                            hints.append(h)
                         }
                    }
                }
                
            }
        }
    }
    if hints.count == 0 {
        return nil
    }
    return Set(hints)
}

/*
Type Two situation, we have one value that is 
the only one for a box row or col
*/

/*
Type Three situation
we have 3 instances of 3 of a kind
*/

/*
Type Four Situation
we have a cycle like [1,2] [2,3] [3,1]
*/


func calculateHintsForThisPosition() {
    if let hints = getTypeOneHints() {
        hintList = Array(hints)
        /*
        ha.sortInPlace()
        for h in hintList {
            Swift.print("\(h)")
        }
        */
    }
    if hintList.count == 0 {
        runAlert("no hints right now")
    }
}


