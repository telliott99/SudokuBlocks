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
