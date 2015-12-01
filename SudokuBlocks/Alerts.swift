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
    s += "Command-z to go back one\n"
    s += "(a single move or a constraint cycle)\n\n"
    s += "Note: applying constraints may uncover\n"
    s += "a problem with a previous move"
    runAlert(s, style: .InformationalAlertStyle)
}

func showHintHelpAsAlert() {
    var s = ""
    s += "Press spacebar to show/hide hints\n"
    s += "Hint types are color-coded\n"
    s += "Arrows cycle through hints\n"
    s += "\n"
    s += "Hints based on analysis of a group\n"
    s += "\t(rows, cols or boxes)\n"
    s += "\n"
    s += "Types:\n"
    s += "1:  repeated twos [1,2] .. [1,2]\n"
    s += "2:  unique value for group\n"
    s += "3:  a cycle [1,2] .. [2,3] .. [3,1]\n"
    runAlert(s, style: .InformationalAlertStyle)
}


