import Cocoa

class MainWindowController: NSWindowController {
    
    // We know these guys exist!
    @IBOutlet weak var textField: NSTextField!
    @IBOutlet weak var labelTextField: NSTextField!
    @IBOutlet weak var popUp: NSPopUpButton!
    
    override func windowDidLoad() {
        super.windowDidLoad()
        getRandomPuzzle(self)
        showCurrentState(self)
    }
    
    override var windowNibName: String {
        return "MainWindowController"
    }

    // should show an alert on failure
    
    @IBAction func loadText(sender: AnyObject) {
        let s = textField.stringValue
        // print("textField.stringValue: \(s)")
        let result = loadPuzzleDataFromString(s)
        if result {
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
        applyConstraintsForFilledSquaresOnce()
    }
    
    
    @IBAction func requestExhaustiveClean(sender: AnyObject) {
        applyConstraintsForFilledSquaresExhaustively()
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
        applyConstraintsForFilledSquaresOnce()
        
        let s2 = getCurrentStateAsString()  // has newlines
        textField.stringValue = s2
        labelTextField.stringValue = key
        unSelectTextField(textField)
        
        self.window!.display()
    }
    
    @IBAction func undo(sender: AnyObject) {
        undoLastMove()
        refreshScreen()
    }
    
    @IBAction func setNewBreakpoint(sender: AnyObject) {
        addNewBreakpoint()
    }

    @IBAction func returnToLastBreakpoint(sender: AnyObject) {
        restoreLastBreakpoint()
    }
    
    @IBAction func reset(sender: AnyObject) {
        if moveL.count == 0 {
            return
        }
        resetPuzzle()
    }
    
    @IBAction func showHints(sender: AnyObject) {
        setHintStatus(true)
        calculateHintsForThisPosition()
        self.window!.display()
    }
    
    @IBAction func hideHints(sender: AnyObject) {
        setHintStatus(false)
        self.window!.display()
    }
}
