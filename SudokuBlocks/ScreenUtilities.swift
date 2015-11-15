import Cocoa

// makes refresh available to Swift files
func refreshScreen() {
    let appDelegate = NSApplication.sharedApplication().delegate as! AppDelegate
    let windowController = appDelegate.mainWindowController!
    let w = windowController.window!
    w.display()
}

func runAlert(s: String) -> Bool {
    let a: NSAlert = NSAlert()
    a.messageText = s
    //a.informativeText = text
    a.alertStyle = NSAlertStyle.WarningAlertStyle
    a.addButtonWithTitle("OK")
    //a.addButtonWithTitle("Cancel")
    let res = a.runModal()
    if res == NSAlertFirstButtonReturn {
        return true
    }
    return false
}

func unSelectTextField(tf: NSTextField) {
    if let window = NSApplication.sharedApplication().mainWindow {
        let textEditor = window.fieldEditor(true, forObject: tf)!
        let range = NSRange(0..<0)
        textEditor.selectedRange = range
    }
}