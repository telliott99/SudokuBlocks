import Cocoa

class TextWindowController: NSWindowController {

    @IBOutlet weak var textField: NSTextField!
    @IBOutlet weak var labelTextField: NSTextField!
    
    @IBOutlet weak var appDelegate: NSApplicationDelegate!

    override func windowDidLoad() {
        super.windowDidLoad()

        // Implement this method to handle any initialization after your window controller's window has been loaded from its nib file.
    }
    
    override var windowNibName: String {
        return "TextWindowController"
    }
    
    @IBAction func loadTextAsPuzzle(sender: AnyObject) {
        let s = textField.stringValue
        // print("textField.stringValue: \(s)")
        
        let result = loadPuzzleDataFromString("", value: s)
        if result {
            labelTextField.stringValue = "custom puzzle"
            let appDelegate = NSApplication.sharedApplication().delegate as! AppDelegate
            
            if let mwc = appDelegate.mainWindowController {
                if let w = mwc.window {
                    mwc.hideHints(self)
                    showCurrentState()
                    
                    w.orderFront(self)
                    w.display()
                }
            }
        }
    }
    
    func showCurrentState() {
        let s = getCurrentStateAsString()
        Swift.print("showCurrentState \(s) \(self.textField)")
        
        let s2 = getCurrentStateAsString()  // has newlines
        
        let appDelegate = NSApplication.sharedApplication().delegate as! AppDelegate
        appDelegate.mainWindowController!.hideHints()
        
        // needed so that textField != nil etc.
        self.window!.display()
        
        textField.stringValue = s2
        labelTextField.stringValue = keyForCurrentPuzzle
        
        unSelectTextField(textField)

        if let w = self.window {
            if nil != self.textField {
                self.textField.stringValue = s
            }
            w.orderFront(self)
            w.makeKeyWindow()
            w.display()
        }
    }
        
    @IBAction func writeToFile(sender: AnyObject) {
        let s = getCurrentStateAsString()
        savePuzzleDataToFile(s)
    }
   
}
