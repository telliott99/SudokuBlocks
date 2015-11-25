import Cocoa

class CountView: NSView {
    
    override func drawRect(dirtyRect: NSRect) {
        let backgroundColor = NSColor.greenColor()
        backgroundColor.set()
        NSBezierPath.fillRect(bounds)
    }
}
