import Cocoa

// Not sure what happened to Crayons
// Found this on the web, see below

extension NSColor {
    convenience init(red: Int, green: Int, blue: Int) {
        assert(red >= 0 && red <= 255, "Invalid red component")
        assert(green >= 0 && green <= 255, "Invalid green component")
        assert(blue >= 0 && blue <= 255, "Invalid blue component")
        
        self.init(red: CGFloat(red) / 255.0,
            green: CGFloat(green) / 255.0,
            blue: CGFloat(blue) / 255.0,
            alpha: 1.0)
    }
    
    convenience init(netHex:Int) {
        self.init(red:(netHex >> 16) & 0xff,
            green:(netHex >> 8) & 0xff,
            blue:netHex & 0xff)
    }
}

let maroon = NSColor(netHex: 0x800040)
let cantaloupe = NSColor(netHex: 0xFFCC66)
let banana = NSColor(netHex: 0xFFFF66)
let tangerine = NSColor(netHex: 0xFF8000)
let silver = NSColor(netHex: 0xCCCCCC)
let mercury = NSColor(netHex: 0xE6E6E6)
let lime = NSColor(netHex: 0x80FF00)
let eggplant = NSColor(netHex: 0x400080)

let red = NSColor.redColor()
let black = NSColor.blackColor()
let blue = NSColor.blueColor()

func constructColorList() -> [NSColor] {
    let L = [
        red,
        blue,
        banana,
        NSColor.cyanColor(),
        tangerine,
        NSColor.purpleColor(),
        black,
        NSColor.magentaColor(),
        lime ]
    return L
}

/*
http://www.randomactsofsentience.com/2013/06/os-x-crayon-color-hex-table.html
http://stackoverflow.com/questions/24263007/how-to-use-hex-colour-values-in-swift-ios

.Cayenne { background-color: #800000; }
.Asparagus { background-color: #808000; }
.Clover  { background-color: #008000; }
.Teal  { background-color: #008080; }
.Midnight { background-color: #000080; }
.Plum  { background-color: #800080; }
.Tin  { background-color: #7F7F7F; }
.Nickel  { background-color: #808080; }
.Mocha  { background-color: #804000; }
.Fern  { background-color: #408000; }
.Moss  { background-color: #008040; }
.Ocean  { background-color: #004080; }
.Eggplant { background-color: #400080; }
.Maroon  { background-color: #800040; }
.Steel  { background-color: #666666; }
.Aluminum { background-color: #999999; }
.Marascino { background-color: #FF0000; }
.Lemon  { background-color: #FFFF00; }
.Spring  { background-color: #00FF00; }
.Turquoise { background-color: #00FFFF; }
.Blueberry { background-color: #0000FF; }
.Magenta { background-color: #FF00FF; }
.Iron  { background-color: #4C4C4C; }
.Magnesium { background-color: #B3B3B3; }
.Tangerine { background-color: #FF8000; }
.Lime  { background-color: #80FF00; }
.SeaFoam { background-color: #00FF80; }
.Aqua  { background-color: #0080FF; }
.Grape  { background-color: #8000FF; }
.Strawberry { background-color: #FF0080; }
.Tungsten { background-color: #333333; }
.Silver  { background-color: #CCCCCC; }
.Salmon  { background-color: #FF6666; }
.Banana  { background-color: #FFFF66; }
.Flora  { background-color: #66FF66; }
.Ice  { background-color: #66FFFF; }
.Orchid  { background-color: #6666FF; }
.Bubblegum { background-color: #FF66FF; }
.Lead  { background-color: #191919; }
.Mercury { background-color: #E6E6E6; }
.Cantaloupe { background-color: #FFCC66; }
.Honeydew { background-color: #CCFF66; }
.Spindrift { background-color: #66FFCC; }
.Sky  { background-color: #66CCFF; }
.Lavender { background-color: #CC66FF; }
.Carnation { background-color: #FF6FCF; }
.Licorice { background-color: #000000; }
.Snow  { background-color: #FFFFFF; }
*/
