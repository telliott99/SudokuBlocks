import Cocoa

class MyView: NSView {
    
    override func drawRect(dirtyRect: NSRect) {
        let backgroundColor = NSColor.whiteColor()
        backgroundColor.set()
        NSBezierPath.fillRect(bounds)
        drawDividers()
        retrieveAndPlotData()
    }
    
    override var flipped: Bool { return true }
    
    override func mouseDown(theEvent: NSEvent) {
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
        let f = ((n & 1048576) != 0)
        
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
}
