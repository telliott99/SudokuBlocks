import Cocoa

class MainWindowController: NSWindowController {
    
    // We know these guys exist!
    @IBOutlet weak var popUp: NSPopUpButton!
    @IBOutlet weak var checkbox: NSButton!
    @IBOutlet weak var mainWindowLabelTextField: NSTextField!
    
    @IBOutlet weak var label1: NSTextField!
    @IBOutlet weak var label2: NSTextField!
    @IBOutlet weak var label3: NSTextField!
    
    let emptyString = ""

    override func windowDidLoad() {
        super.windowDidLoad()
        getRandomPuzzle(self)
        // showCurrentState(self)
        label1.textColor = colorForHintType(.one)
        label2.textColor = colorForHintType(.two)
        label3.textColor = colorForHintType(.three)
    }
    
    override var windowNibName: String {
        return "MainWindowController"
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
        
        let result = getRandomDatabasePuzzle(level)
        if result == nil { return }
        
        let (key, s) = result!
        let p = constructPuzzleFromKeyAndString(key, string:s)
        if p == nil { return }
        currentPuzzle = p!
        
        resetLabelTextField()
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
    
    func showHints() {
        showHints(self)
    }
    
    @IBAction func showHints(sender: AnyObject) {
        setHintActive(true)
        self.window!.display()
    }
        
    @IBAction func hideHints(sender: AnyObject) {
        setHintActive(false)    // in HintHelper, see above
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
    
    @IBAction func showHintHelp(sender: AnyObject) {
        showHintHelpAsAlert()
    }

    @IBAction func showTextWindow(sender: AnyObject) {
        let appDelegate = NSApplication.sharedApplication().delegate as! AppDelegate
        
        if let textWindowController = appDelegate.textWindowController {
            textWindowController.showCurrentState()
         }
    }
    
    @IBAction func hideTextWindow(sender: AnyObject) {
        //let appDelegate = NSApplication.sharedApplication().delegate as! AppDelegate
        
        if let w = textWindowController.window {
            w.orderOut(self)
        }
    }
    
    func resetLabelTextField() {
        mainWindowLabelTextField.stringValue  = currentPuzzle.title
    }
    
    @IBAction func labelTextFieldEdited(sender: AnyObject) {
        let s = mainWindowLabelTextField.stringValue
        let result = getDatabasePuzzleForRequestedKey(s)
        if nil != result {
            
            let (key, s) = result!
            let p = constructPuzzleFromKeyAndString(key, string:s)
            if p == nil { return }
            currentPuzzle = p!
            
            resetLabelTextField()
            
            let c = String(key.characters.first!)
            if let i = ["z","m","h","e"].indexOf(c) {
                popUp.selectItemAtIndex(Int(i))
            } else {
                popUp.selectItemAtIndex(0)
            }
            
            if checkbox.state == NSOnState {
                applyConstraintsForFilledSquaresOnce()
            }
            hideHints()
        } else {
            runAlert("No puzzle with that title!")
            resetLabelTextField()
        }
        // this doesn't work at present
        unSelectTextField(mainWindowLabelTextField, controller: self)
        // focusOnPuzzleView()
    }
    
    @IBAction func checkPuzzle(sender: AnyObject) {
        if let group = currentPuzzle.validate() {
            let s = group.joinWithSeparator(" ")
            runAlert("Found a problem: \n\(s)")
        }
        else {
            runAlert("OK: no problems found", style: .InformationalAlertStyle)
        }
    }
}