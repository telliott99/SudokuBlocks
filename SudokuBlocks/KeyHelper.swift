import Foundation

let letters = "ABCDEFGHI"
// let letterArray = Array(arrayLiteral: letters)

let digits =  "123456789"
// let digitArray = Array(arrayLiteral: digits)

func orderedKeyArray() -> [String] {
    var kL = [String]()
    for l in letters.characters {
        for d in digits.characters {
            kL.append(String([l,d]))
        }
    }
    return kL
}

// given a group of keys and a value
// find the key with that value

func getKeyForValue(group: [String], value: IntSet, dataD: DataSet) -> String? {
    for key in group {
        if dataD[key]! == value {
            return key
        }
    }
    return nil
}
