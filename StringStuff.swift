import Foundation

extension String {
    private func divide(s: String, n: Int) -> [String] {
        var ret = [String]()
        var current = s
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
    
    func withNewlines(every n: Int) -> String {
        let ret = divide(self, n: n)
        return ret.joinWithSeparator("\n")
    }
    
    func withoutNewlines() -> String {
        let r = self.characters.split() {$0 == "\n"}.map{String($0)}
        return r.joinWithSeparator("")
    }

}

func getCurrentStateAsString() -> String {
    var arr = [String]()
    let dataD = currentPuzzle.dataD
    let keyList = dataD.keys.sort()
    for key in keyList {
        let data = Array(dataD[key]!)
        if data.count > 1 {
            arr.append("0")
        }
        else {
            arr.append(String(data[0]))
        }
    }
    let s = arr.joinWithSeparator("")

    // could have done this above, just exercising my Extension
    return s.withNewlines(every: 9)
}
