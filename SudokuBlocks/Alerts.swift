import Cocoa

/*
enum NSAlertStyle : UInt {
case WarningAlertStyle
case InformationalAlertStyle
case CriticalAlertStyle
}
*/

func runAlert(s: String, style: NSAlertStyle = .WarningAlertStyle) -> Bool {
    let a: NSAlert = NSAlert()
    // Swift.print(a.window.frame.origin)
    
    a.messageText = s
    //a.informativeText = text
    
    a.alertStyle = style
    a.addButtonWithTitle("OK")
    //a.addButtonWithTitle("Cancel")
    
    let result = a.runModal()
    if result == NSAlertFirstButtonReturn {
        return true
    }
    return false
}

func showHelpAsAlert() {
    var s = ""
    s += "Click to delete a single value\n"
    s += "Command-click to select one value\n"
    s += "Command-z to go back one move\n"
    s += "\n"
    s += "Press spacebar to show/hide hints\n"
    s += "Hint types are color-coded\n"
    s += "Arrows cycle through hints\n"
    runAlert(s, style: .InformationalAlertStyle)
}