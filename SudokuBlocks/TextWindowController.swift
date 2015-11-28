import Cocoa

class TextWindowController: NSWindowController {

    @IBOutlet weak var textField: NSTextField!
    @IBOutlet weak var labelTextField: NSTextField!
    
    weak var mainWindowController: NSWindowController!

    override func windowDidLoad() {
        super.windowDidLoad()
        let appDelegate = NSApplication.sharedApplication().delegate as! AppDelegate
        self.mainWindowController = appDelegate.mainWindowController
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
            
            if let mwc = self.mainWindowController as! MainWindowController! {
                if let w = mwc.window {
                    mwc.requestClean(self)
                    mwc.changeLabelTextField(labelTextField.stringValue)
                    w.orderFront(self)
                    w.display()
                }
            }
        }
    }
    
    func showCurrentState() {
        let s = getCurrentStateAsString()  // has newlines
        appDelegate.mainWindowController!.hideHints()
        
        // needed so that textField != nil etc.
        self.window!.display()
        
        textField.stringValue = s
        labelTextField.stringValue = keyForCurrentPuzzle
        
        if let mwc = self.mainWindowController as! MainWindowController! {
            mwc.changeLabelTextField(labelTextField.stringValue)
        }
        
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
        if let w = self.window {
            w.orderOut(self)
            }
    }
   
    // shows an alert on failure
    @IBAction func loadFile(sender: AnyObject) {
        if let s = loadFileHandler() {
            loadPuzzleDataFromString("", value: s)
            if let mwc = self.mainWindowController as! MainWindowController! {
                mwc.changeLabelTextField("")
            }
            appDelegate.mainWindowController!.hideHints()
         }
    }

}
