import Foundation

/*
this part could definitely be fancier, like
a TableView with keys then pick
current choices are easy, medium, hard, evil
not sure where the ratings came from now, some are iffy
*/

func getDatabasePuzzle(level: Difficulty) -> (String, String)? {
    let path = NSBundle.mainBundle().pathForResource("db", ofType: "plist")
    
    // pretty confident, aren't we
    let D = NSDictionary(contentsOfFile: path!)!
    var kL = [String]()
    for key in D.allKeys {
        kL.append(String(key))
    }
    
    // filter kL based on Difficulty
    switch level {
    case .easy:
        kL = kL.filter( { $0.characters.first == "z" } )
    case .medium:
        kL = kL.filter( { $0.characters.first == "m" } )
    case .hard:
        kL = kL.filter( { $0.characters.first == "h" } )
    case .evil:
        kL = kL.filter( { $0.characters.first == "e" } )
    }
    
    let i = Int(arc4random_uniform(UInt32(kL.count)))
    let key = String(kL[i])
    let s = "\(D[key]!)"
    return (key,s)
}
