import Cocoa

func loadFileHandler() -> String? {
    let op = NSOpenPanel()
    
    op.prompt = "Open File:"
    // op.title = "A title"
    // op.message = "A message"
    // op.canChooseFiles = true  // default
    // op.worksWhenModal = true  // default
    
    op.allowsMultipleSelection = false
    // op.canChooseDirectories = true  // default
    op.resolvesAliases = true
    op.allowedFileTypes = ["txt"]

    let home = NSHomeDirectory()
    let d = home.stringByAppendingString("/Desktop/")
    op.directoryURL = NSURL(string: d)
    op.runModal()
    // op.orderOut()
    
    // op.URL contains the user's choice
    if op.URL == nil {
        return nil
    }
    var s: String
    do { s = try String(contentsOfURL:op.URL!, encoding: NSUTF8StringEncoding) }
    catch { return nil }
    
    let vs = validatedPuzzleString(s)
    return vs
}

func savePuzzleDataToFile(s: String) {
    let sp = NSSavePanel()
    
    sp.prompt = "Save File:"
    sp.title = "A title"
    sp.message = "A message"
    // sp.worksWhenModal = true  // default
    
    let home = NSHomeDirectory()
    let d = home.stringByAppendingString("/Desktop/")
    sp.directoryURL = NSURL(string: d)
    sp.allowedFileTypes = ["txt"]

    //sp.runModal()
    
    sp.beginWithCompletionHandler{ (result: Int) -> Void in
        Swift.print(result)
        if result == NSFileHandlingPanelOKButton {
            let exportedFileURL = sp.URL!
            do { try s.writeToURL(exportedFileURL, atomically:true,
                encoding:NSUTF8StringEncoding) }
            catch {  }
        }
    }
}

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
