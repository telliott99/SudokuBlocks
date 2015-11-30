import Cocoa

class TextWindowController: NSWindowController {

    @IBOutlet weak var textField: NSTextField!
    @IBOutlet weak var labelTextField: NSTextField!

    
    override func windowDidLoad() {
        super.windowDidLoad()
    }
    
    override var windowNibName: String {
        return "TextWindowController"
    }
    
    @IBAction func loadTextAsPuzzle(sender: AnyObject) {
        let s = textField.stringValue
        // print("textField.stringValue: \(s)")
        
        let result = loadPuzzleDataFromString("", s: s)
        if result {
            labelTextField.stringValue = "custom puzzle"
            
            if let w = mainWindowController.window {
                mainWindowController.requestClean(self)
                mainWindowController.resetLabelTextField()
                w.orderFront(self)
                w.display()
            }
        }
    }
    
    func showCurrentState() {
        let s = currentPuzzle.stringRepresentation()  // has newlines
        // appDelegate obtained from Mutators
        appDelegate.mainWindowController!.hideHints()
        
        // needed so that textField != nil etc.
        self.window!.display()
        
        textField.stringValue = String(currentPuzzle)
        labelTextField.stringValue = currentPuzzle.title
        unSelectTextField(textField)
        
        mainWindowController.resetLabelTextField()

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
        let s = currentPuzzle.stringRepresentation()
        savePuzzleDataToFile(s)
        if let w = self.window {
            w.orderOut(self)
            }
    }
   
    // shows an alert on failure
    @IBAction func loadFile(sender: AnyObject) {
        if let s = loadFileHandler() {
            loadPuzzleDataFromString("", s: s)
            mainWindowController.resetLabelTextField()
            mainWindowController.hideHints()
         }
    }

}
