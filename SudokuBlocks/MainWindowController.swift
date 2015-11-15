import Cocoa

class MainWindowController: NSWindowController {
    
    // I know these guys exist!
    @IBOutlet weak var textField: NSTextField!
    @IBOutlet weak var labelTextField: NSTextField!
    @IBOutlet weak var popUp: NSPopUpButton!
    
    override func windowDidLoad() {
        super.windowDidLoad()
        labelTextField.stringValue = "no puzzle yet"
    }
    
    override var windowNibName: String {
        return "MainWindowController"
    }

    // should show an alert on failure
    @IBAction func loadText(sender: AnyObject) {
        let s = textField.stringValue
        // print("textField.stringValue: \(s)")
        let result = loadPuzzleDataFromString(s)
        if (result) {
            labelTextField.stringValue = "custom puzzle"
            showCurrentState(self)
        }
    }
    
    @IBAction func loadFile(sender: AnyObject) {
        if let s = loadFileHandler() {
            loadPuzzleDataFromString(s)
            showCurrentState(self)
        }
    }

    @IBAction func requestClean(sender: AnyObject) {
        applyConstraintsForAllFilledSquares()
    }
    
    @IBAction func showCurrentState(sender: AnyObject) {
        let s = getCurrentStateAsString()
        textField.stringValue = s
        self.window!.display()
    }
    
    @IBAction func writeToFile(sender: AnyObject) {
        let s = getCurrentStateAsString()
        savePuzzleDataToFile(s)
    }
    
    @IBAction func getRandomPuzzle(sender: AnyObject) {
        
        // read popUp
        let a: [Difficulty] = [.easy, .medium, .hard, .evil]
        let level = a[popUp.indexOfSelectedItem]
        let result = getDatabasePuzzle(level)
        
        if (result == nil) { return }
        
        let (key, value) = result!
        loadPuzzleDataFromString(value)
        
        let s2 = getCurrentStateAsString()  // has newlines
        textField.stringValue = s2
        labelTextField.stringValue = key
        unSelectTextField(textField)
        self.window!.display()
    }
    
    @IBAction func undo(sender: AnyObject) {
        undoLastMove()
    }
}
