## MTLabel version 0.0.2

### Author: Michal Tuszynski
### Contributors: Martin Hwasser

### Description:

By default, UIKit's UILabel provides many limitations, such as unable to customize line height attribute. This is a simple sublass of UIView which uses CoreText framework to draw text. It's still a work in progress so use it at your own risk.

### Requirements

MTLabel uses CoreText  framework, so add it to your project before using MTLabel.

### Features:

- Customize line spacing
- You can specify if you want the label to resize itself based on text height
- Supports almost all features of UILabel

### Known issues:

- Be careful when using MTLabel with UITableView. During the text drawing there is a black background being drawn, so I use performSelector:withObject:afterDelay: method to draw a clear background after drawing text. When tableview is being scrolled, it prevents the method from being executed, so you have to set the clear background your self for the changes to take place.

- Line limiting still doesn't work, but it will soon

### To do:

- Limiting to number of lines
- Customizable margin support
- Highliting portions of text with user-defined color

### Changelog:

#### v 0.0.1

- Added initial version of MTLabel with support for custom line-height

#### v 0.0.2

- Added support for text alignment: left, right, center and justify
- Added support for resizing label's frame to match the text size inside

### License

MTLabel is under Apache v2 license. 

