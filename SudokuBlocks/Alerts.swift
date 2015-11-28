import Cocoa

func runAlert(s: String) -> Bool {
    let a: NSAlert = NSAlert()
    Swift.print(a.window.frame.origin)
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

func showHelpAsAlert() {
    var s = ""
    s += "Click to delete a on valeue\n"
    s += "Command-click to select one value\n"
    s += "Command-z to go back oen move\n"
    s += "\n"
    s += "Toggle spacebar to show or hide hints\n"
    s += "Hint types are color-coded\n"
    s += "Arrows cycle through hints\n"
    runAlert(s)
}