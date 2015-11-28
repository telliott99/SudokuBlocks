import Cocoa

@NSApplicationMain
class AppDelegate: NSObject, NSApplicationDelegate {

    var mainWindowController: MainWindowController?
    var textWindowController: TextWindowController?

    
    func applicationDidFinishLaunching(aNotification: NSNotification) {
        
        // Create a window controller with a XIB file of the same name
        let mainWindowController = MainWindowController()
        
        // Put the window of the window controller on screen
        mainWindowController.showWindow( self)
        
        // Hillegass book says:  do setup first, then assignment:
        
        // Set the property to point to the window controller
        self.mainWindowController = mainWindowController
        
        let textWindowController = TextWindowController()
        
        self.textWindowController = textWindowController
        

        }
}

