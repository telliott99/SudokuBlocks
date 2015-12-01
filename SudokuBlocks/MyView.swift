import Cocoa

class MyView: NSView {
    
    override func drawRect(dirtyRect: NSRect) {
        let backgroundColor = NSColor.whiteColor()
        backgroundColor.set()
        NSBezierPath.fillRect(bounds)
        drawDividers()
        retrieveAndPlotData()
        displayHints()
    }
    
    // this means we draw starting from upper left
    override var flipped: Bool { return true }
    
    // detect the clicks that affect blocks
    override func mouseDown(theEvent: NSEvent) {
        // immediately turn off display of hints
        setHintActive(false)
                
        let f = commandKeyWasPressed(theEvent)
        
        let q = theEvent.locationInWindow
        let p = self.convertPoint(q, fromView:self.superview)
        
        // stupid, but reliable
        // k,v enumeration through the Dictionary
        for (key,r) in rectD {
            if r.contains(p) {
                respondToClick(key, point: p, rect: r, cmd: f)
                return
            }
        }
    }
    
    // we do this to get key events
    override var acceptsFirstResponder: Bool { return true }
    
    // detect CMD+z, spacebar and left & right arrows
    @IBAction override func keyDown(theEvent: NSEvent) {
        
        super.keyDown(theEvent)
        //Swift.print(theEvent.keyCode)
        
        if theEvent.keyCode == 6 && commandKeyWasPressed(theEvent) {
            undoLastMove()
            refreshScreen()
            return
        }
        
        let n = hintList.count
        
        if theEvent.keyCode == 49 {
            calculateHintsForThisPosition()
            // Swift.print("spacebar handler, \(hintList.count) hints, active: \(hintActive)")
            
            if hintActive {
                // couldn't figure out yet how to save this reference
                
                let appDelegate = NSApplication.sharedApplication().delegate as! AppDelegate
                if let mwc = appDelegate.mainWindowController as MainWindowController! {
                    mwc.hideHints(self)
                }
            }
            else {
                let appDelegate = NSApplication.sharedApplication().delegate as! AppDelegate
                if let mwc = appDelegate.mainWindowController as MainWindowController! {
                    mwc.showHints()
                }
            }
            refreshScreen()
            return
        }

        if n == 0 {
            Swift.print("no hintList")
            return
        }
        
        if theEvent.keyCode == 123 {
            // Swift.print("left arrow handler")
            // left arrow
            if selectedHint == 0 {
                selectedHint = n - 1
            }
            else {
                selectedHint -= 1
            }
            refreshScreen()
            return
        }
        
        if theEvent.keyCode == 124 {
            // Swift.print("right arrow handler")
            // right arrow
            if selectedHint == n - 1 {
                selectedHint = 0
            }
            else {
                selectedHint += 1
            }
            refreshScreen()
            return
        }
    }
    
}
