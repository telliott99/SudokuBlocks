import Cocoa

class MyView: NSView {
    
    override func drawRect(dirtyRect: NSRect) {
        let backgroundColor = NSColor.whiteColor()
        backgroundColor.set()
        NSBezierPath.fillRect(bounds)
        drawDividers()
        retrieveAndPlotData()
    }
    
    // this means we draw starting from upper left
    override var flipped: Bool { return true }
    
    // detect the clicks that affect blocks
    override func mouseDown(theEvent: NSEvent) {
                
        let f = commandKeyPressed(theEvent)
        
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

    // detect CMD+z
    @IBAction override func keyDown(theEvent: NSEvent) {
        super.keyDown(theEvent)
        if theEvent.keyCode == 6 && commandKeyPressed(theEvent) {
            undoLastMove()
            refreshScreen()
        }
    }
}
