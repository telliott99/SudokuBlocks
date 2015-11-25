import Foundation

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
    // return a set of Hint objects if we find any
    var hints = [Hint]()
    
    for group in boxes + rows + cols {
        if let results = findRepeatedTwos(group) {
            
            for kp in results {
                // a KeyPair has __ k1 and k2
                let repeatedIntSet = dataD[kp.k1]!
                
                for key in group {
                    if key == kp.k1 || key == kp.k2 {
                        continue
                    }
                    
                    let set = Set(dataD[key]!)
                    
                    // if both values are present
                    if repeatedIntSet.isSubsetOf(set) {
                        let iSet = set.subtract(repeatedIntSet)
                        let h = Hint(key: key, value: iSet,
                            keyPair: kp, hintType: .one)
                        hints.append(h)
                    }
                    
                    // if only one of the two values is present
                    // n is an Int
                    
                    for n in repeatedIntSet {
                        if set.contains(n) {
                            let intersection = set.intersect(repeatedIntSet)
                            let iSet = set.subtract(intersection)
                            let h = Hint(key: key, value: iSet,
                                keyPair: kp, hintType: .one)
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
Type Two situation
we have one value that is
the only one of its type 
for a box row or col
*/

func getTypeTwoHints() -> Set<Hint>? {
    // return a set of Hint objects if we find any
    var hints = [Hint]()
    
    for group in boxes + rows + cols {
        // gather all the values
        var arr = [Int]()
        for key in group {
            arr += Array(dataD[key]!)
        }
        
        // get the singletons
        var valueList = [Int]()
        for value in Set(arr) {
            if arr.elementCount(value) == 1 {
                valueList.append(value)
            }
        }
        
        // find the affected keys
        for value in valueList {
            for key in group {
                let data = dataD[key]!
                if data.count > 1 && data.contains(value) {
                    let kp = KeyPair(first: group.first!, second: group.last!)
                    let set = Set([value])
                    
                    // and construct hints
                    let h = Hint(key: key, value: set,
                        keyPair: kp, hintType: .two)
                    hints.append(h)
                }
            }
        }
    }
    return Set(hints)
}


/*
Type Three Situation
we have a cycle like [1,2] [2,3] [3,1]
*/

func getTypeThreeHints() -> Set<Hint>? {
    // return an array of Hint objects if we find any
    var hints = [Hint]()
    
    for group in boxes + rows + cols {
        let values : [IntSet] = group.map( { dataD[$0]! } )
        let arr = values.filter( { $0.count == 2 } )
        for set1 in arr {
            for set2 in arr {
                for set3 in arr {
                    if set1.intersect(set2).count == 1 &&
                       set1.intersect(set3).count == 1 &&
                       set2.intersect(set3).count == 1 {
                        let k1 = group.filter( { dataD[$0] == set1 } ).first!
                        let k2 = group.filter( { dataD[$0] == set2 } ).first!
                        let k3 = group.filter( { dataD[$0] == set3 } ).first!
                        let h = Hint(key: k1, value: set1,
                            keyPair: KeyPair(first: k2, second:k3),
                            hintType: .three)
                        hints.append(h)
                    }
                }
            }
        }
        
        
        if arr.count < 2 {
            return nil
        }
        // getting complicated!
    }

return Set(hints)
}


/*
Type Four situation
we have 3 instances of 3 of a kind
*/


