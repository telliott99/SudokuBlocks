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
    do {
        s = try String(contentsOfURL:op.URL!, encoding: NSUTF8StringEncoding)
    }
    catch {
        // this doesn't work, alert disappears with return..
        // runAlert("Unable to load a puzzle from that file!")
        return nil
    }
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
        // Swift.print(result)
        if result == NSFileHandlingPanelOKButton {
            let exportedFileURL = sp.URL!
            do { try s.writeToURL(exportedFileURL, atomically:true,
                encoding:NSUTF8StringEncoding) }
            catch { runAlert("Unable to save!") }
        }
    }
}
