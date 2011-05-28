## MTLabel version 0.0.1

### Author: Michal Tuszynski

### Description:

By default, UIKit's UILabel provides many limitations, such as unable to custumize line height attribute or make the text unlimited lines long. This is a simple sublass of UIView which uses CoreText framework to draw text. It's still a work in progress so use it at your own risk.

### Requirements

MTLabel uses CoreText  framework, so add it to your project before using MTLabel.

### Features:

- Customize line spacing
- Draw text with unlimited number of lines (UILabel forces you to specify number of lines)
- Resize the label the fit the text inside
- Works just like UILabel (there are still improvements to be made to fully support all UILabel features, so stay tuned for updates)

### Known issues:

- Be careful when using MTLabel with UITableView. During the text drawing there is a black background being drawn, so I use performSelector:withObject:afterDelay: method to draw a clear background after drawing text. When tableview is being scrolled, it prevents the method from being executed, so you have to set the clear background your self for the changes to take place.

- Line limiting still doesn't work, but it will soon
- Same goes for text alignment

### To do:

- Full text alignment support,
- Limiting to number of lines
- Customizable margin support

### License

MTLabel is under Apache v2 license. 
