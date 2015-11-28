import Cocoa

class MainWindowController: NSWindowController {
    
    // We know these guys exist!
    @IBOutlet weak var popUp: NSPopUpButton!
    @IBOutlet weak var checkbox: NSButton!
    
    @IBOutlet weak var label1: NSTextField!
    @IBOutlet weak var label2: NSTextField!
    @IBOutlet weak var label3: NSTextField!
    
    let emptyString = ""
    
    override func windowDidLoad() {
        super.windowDidLoad()
        getRandomPuzzle(self)
        // showCurrentState(self)
    }
    
    override var windowNibName: String {
        return "MainWindowController"
    }

    // should show an alert on failure
        
    @IBAction func loadFile(sender: AnyObject) {
        if let s = loadFileHandler() {
            loadPuzzleDataFromString("", value: s)
            hideHints(self)
            // showCurrentState(self)
        }
    }

    @IBAction func requestClean(sender: AnyObject) {
        applyConstraintsForFilledSquaresOnce()
        hideHints(self)
        self.window!.display()
    }
    
    
    @IBAction func requestExhaustiveClean(sender: AnyObject) {
        applyConstraintsForFilledSquaresExhaustively()
        hideHints(self)
        self.window!.display()
    }
        
    @IBAction func getRandomPuzzle(sender: AnyObject) {
        
        // read popUp
        let a: [Difficulty] = [.easy, .medium, .hard, .evil]
        let level = a[popUp.indexOfSelectedItem]
        let result = getDatabasePuzzle(level)
        
        if (result == nil) { return }
        let (key, value) = result!
        loadPuzzleDataFromString(key, value: value)
        
        if checkbox.state == NSOnState {
            applyConstraintsForFilledSquaresOnce()
        }
        hideHints()

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
        hideHints(self)
    }
    
    @IBAction func showHints(sender: AnyObject) {
        setHintStatus(false)
        label1.textColor = colorForHintType(.one)
        label2.textColor = colorForHintType(.two)
        label3.textColor = colorForHintType(.three)

        setHintStatus(true)
        calculateHintsForThisPosition()
        self.window!.display()
    }
    
    @IBAction func hideHints(sender: AnyObject) {
        setHintStatus(false)
        hintList = [Hint]()
        label1.stringValue = emptyString
        label2.stringValue = emptyString
        label3.stringValue = emptyString
        self.window!.display()
    }
    
    // OK b/c different signature than the @IBAction
    // can't call that one from Swift files  why??
    func hideHints() {
        hideHints(self)
    }
    
    @IBAction func showHelp(sender: AnyObject) {
        showHelpAsAlert()
    }
    
    @IBAction func showTextWindow(sender: AnyObject) {
        let appDelegate = NSApplication.sharedApplication().delegate as! AppDelegate
        
        if let textWindowController = appDelegate.textWindowController {
            textWindowController.showCurrentState()
         }
    }
    
    @IBAction func hideTextWindow(sender: AnyObject) {
        let appDelegate = NSApplication.sharedApplication().delegate as! AppDelegate
        
        if let textWindowController = appDelegate.textWindowController {
            if let w = textWindowController.window {
                w.orderOut(self)
            }
        }
    }

}
