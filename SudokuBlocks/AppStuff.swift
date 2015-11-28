import Cocoa

// make mwc available to Swift files

let ad = NSApplication.sharedApplication().delegate as! AppDelegate
let mainWindowController = ad.mainWindowController as MainWindowController!
let textWindowController = ad.textWindowController as TextWindowController!

