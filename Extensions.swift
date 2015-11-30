import Foundation

/*
convenience method
count how many times
a particular IntSet is found in an array
*/

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


extension String {
    func divideStringIntoChunks(chunkSize n: Int) -> [String] {
        var ret = [String]()
        var current = self
        while true {
            let m = current.characters.count
            if m == 0 {
                break
            }
            if m < n {
                ret.append(current)
                break
            }
            let i = current.startIndex.advancedBy(n)
            let front = current.substringToIndex(i)
            ret.append(front)
            current = current.substringFromIndex(i)
        }
        return ret
    }
    
    
    func insertSeparator(sep: String, every n: Int) -> String {
        let ret = self.divideStringIntoChunks(chunkSize: n)
        return ret.joinWithSeparator(sep)
    }
    
    func stripOccurrencesOfCharacter(c: Character) -> String {
        /*
        get the CharacterView, like an [Character]
        split to chunks on newlines
        split takes a closure

        the results are not Strings 
        which joinWithSeparator requires,
        so do the conversion for each one with map
        */
        
        let r = self.characters.split() {$0 == c }.map{String($0)}
        return r.joinWithSeparator("")
    }

}
