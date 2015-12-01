import Cocoa

// makes refresh available to Swift files

func refreshScreen() {
    // not sure why, but this one is required
    // despite the def in Mutators
    
    let appDelegate = NSApplication.sharedApplication().delegate as! AppDelegate
    
    if let windowController = appDelegate.mainWindowController {
        if let w = windowController.window {
            w.display()
        }
    }
}

func unSelectTextField(tf: NSTextField, controller: NSWindowController) {
    // Swift.print("unSelect \(tf) \(controller)")
    if let window = controller.window {
        let textEditor = window.fieldEditor(true, forObject: tf)!
        let range = NSRange(0..<0)
        textEditor.selectedRange = range
    }
}

func commandKeyWasPressed(theEvent: NSEvent) -> Bool {
    /*
    docs aren't particularly clear
    by examining theEvent.modifierFlags.rawValue
    
    CommandKeyMask bit is set in 1048576
    >>> bin(1048576)  # 2**20
    '0b100000000000000000000'
    
    so... just do
    1048576 & theEvent.modifierFlags.rawValue
    if its non-zero, CommandKeyMask bit is set
    
    also saw 1048584
    in Playground
    1048584 & 1048576    // 1048576
    */
    
    let n = theEvent.modifierFlags.rawValue
    return ((n & 1048576) != 0)
}



