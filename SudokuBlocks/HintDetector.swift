import Foundation

/*
typealias IntSet = Set<Int>
typealias DataSet = [String:IntSet]
*/

var a = [IntSet]()

func findRepeatedTwos(neighbors: [String]) -> [KeyArray]? {
    let arr = currentPuzzle.getIntSetsForKeyArray(neighbors)
    
    // filter for 2 elements
    let twos = arr.filter( { $0.count == 2 } )
    
    var repeatsTwice = [IntSet]()
    for set in Set(twos) {
        if arr.elementCount(set) == 2 {
            repeatsTwice.append(set)
        }
    }
    
    // repeatsTwice contains IntSets that occur twice
    var results = [KeyArray]()
    
    // now we need the corresponding keys, we return *both* keys
    for set in repeatsTwice {
        /*
        var t = [String]()
        for key in neighbors {
            if set == dataD[key] {
                t.append(key)
            }
        }
        */
        
        // rewrite more idiomatically
        let t = neighbors.filter( { set == currentPuzzle.dataD[$0] } )
        // results.append(KeyPair(first:t[0], second:t[1]))
        results.append(t)
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

func getTypeOneHints() -> [Hint]? {
    // return a set of Hint objects if we find any
    var hints = [Hint]()
    let dataD = currentPuzzle.dataD
    for (group,kind) in getAllGroups() {
        if let results = findRepeatedTwos(group) {
            
            for keyArray in results {
                
                let repeatedIntSet = dataD[keyArray[0]]!
                
                for key in group {
                    if keyArray.contains(key) {
                         continue
                    }
                    
                    let set = Set(dataD[key]!)
                    
                    // if both values are present
                    if repeatedIntSet.isSubsetOf(set) {
                        let iSet = set.subtract(repeatedIntSet)
                        
                        let h = Hint(
                            key: key,
                            iSet: iSet,
                            keyArray: keyArray,
                            hintType: .one,
                            affectedGroup: group.sort(),
                            kind: kind )
                        
                        hints.append(h)
                    }
                    
                    // if only one of the two values is present
                    // n is an Int
                    
                    for n in repeatedIntSet {
                        if set.contains(n) {
                            let intersection = set.intersect(repeatedIntSet)
                            let iSet = set.subtract(intersection)
                            
                            let h = Hint(
                                key: key,
                                iSet: iSet,
                                keyArray: keyArray,
                                hintType: .one,
                                affectedGroup: group.sort(),
                                kind: kind)
                            
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
    return Array(Set(hints))
}

/*
Type Two situation
we have one value that is
the only one of its type 
for a box row or col
*/

func getTypeTwoHints() -> [Hint]? {
    // return a set of Hint objects if we find any
    var hints = [Hint]()
    let dataD = currentPuzzle.dataD
    
    for (group,kind) in getAllGroups() {
        // gather all the values
        var arr = [Int]()
        for key in group {
            arr += Array(dataD[key]!)
        }
        
        // get the singletons
        var setsWithOne = [Int]()
        for value in Set(arr) {
            if arr.elementCount(value) == 1 {
                setsWithOne.append(value)
            }
        }
        
        // find the affected keys
        for value in setsWithOne {
            for key in group {
                let data = dataD[key]!
                
                if data.count > 1 && data.contains(value) {
                    let set = Set([value])
                    
                    // this KeyArray is meaningless for .two
                    let h = Hint(
                        key: key,
                        iSet: set,
                        keyArray: [] as KeyArray,
                        hintType: .two,
                        affectedGroup: group.sort(),
                        kind: kind)
                    
                    hints.append(h)
                }
            }
        }
    }
    return Array(Set(hints))
}


/*
Type Three Situation
we have a cycle like [1,2] [2,3] [3,1]
so any other occurrence of 1, 2, or 3 deserves a hint
*/


func getTypeThreeHints() -> [Hint]? {
    // return an array of Hint objects if we find any
    var hints = [Hint]()
    let dataD = currentPuzzle.dataD
    for (group,kind) in getAllGroups() {
        
        let values : [IntSet] = group.map( { dataD[$0]! } )
        let setsWithTwo = values.filter( { $0.count == 2 } )
        if setsWithTwo.count < 3 { continue }
        
        var cycleList = [IntSet]()

        // better or worse than enumeration?
        for set1 in setsWithTwo {
            for set2 in setsWithTwo {
                if set1 == set2 { continue }
                for set3 in setsWithTwo {
                    if set1 == set3 { continue }
                    if set2 == set3 { continue }
                    
                    // Swift.print("Got 3:  \(set1) \(set2) \(set3)")
                    if Set(set1.union(set2).union(set3)).count != 3 {
                        continue
                    }
                    cycleList = [set1,set2,set3]
                }
            }
        }
        
        // we have one cycle (perhaps not all of them, but ignore this)
        // now find an affected set
        for key in group {
            let set = dataD[key]!
            
            // for each set of the array and each set in the cycle
            // if the set is not in the cycle
            // but shares at least one element, possibly two

            if cycleList.contains(set) { continue }
            for set2 in cycleList {
                if !set.intersect(set2).isEmpty {
                    
                    // find the keys for the sets in the cycle list
                    let k1 = currentPuzzle.keyForValue(group,
                        value: cycleList[0],
                        dataD: dataD)!
                    let k2 = currentPuzzle.keyForValue(group,
                        value: cycleList[1],
                        dataD: dataD)!
                    let k3 = currentPuzzle.keyForValue(group,
                        value: cycleList[2],
                        dataD: dataD)!
                    
                    let h = Hint(
                        key: key,
                        iSet: set,
                        keyArray: [k1,k2,k3],
                        hintType: .three,
                        affectedGroup: group.sort(),
                        kind: kind )
                    
                    hints.append(h)

                }
            }
        }
    }
    return Array(Set(hints))
}


/*
Type Four situation
we have 3 instances of 3 of a kind
*/


