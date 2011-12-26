//
//  MTLabel.m
//  CustomLabelTest
//
//  Copyright 2011 Michal Tuszynski
//
//  Licensed under the Apache License, Version 2.0 (the "License");
//  you may not use this file except in compliance with the License.
//  You may obtain a copy of the License at
//
//  http://www.apache.org/licenses/LICENSE-2.0
//
//  Unless required by applicable law or agreed to in writing, software
//  distributed under the License is distributed on an "AS IS" BASIS,
//  WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
//  See the License for the specific language governing permissions and
//  limitations under the License.

#import "MTLabel.h"
#import <CoreText/CoreText.h>
#import <QuartzCore/QuartzCore.h>

#define DEFAULT_FONT_SIZE 12

@interface MTLabel ()

-(void)drawTransparentBackground;

@end

CGRect CTLineGetTypographicBoundsAsRect(CTLineRef line, CGPoint lineOrigin) {
	CGFloat ascent = 0;
	CGFloat descent = 0;
	CGFloat leading = 0;
	CGFloat width = CTLineGetTypographicBounds(line, &ascent, &descent, &leading);
	CGFloat height = ascent + descent;
    
	return CGRectMake(lineOrigin.x,
					  lineOrigin.y - descent,
					  width,
					  height);
}
@implementation MTLabel

@synthesize _text;
@synthesize _lineHeight, _textHeight, _minimumFontSize;
@synthesize _numberOfLines;
@synthesize _font;
@synthesize _fontColor, _fontHighlightColor;
@synthesize _limitToNumberOfLines, _shouldResizeToFit;
@synthesize _textAlignment;
@synthesize delegate;
@synthesize _adjustSizeToFit;
@synthesize shadowOffset;


#pragma mark - Setters

-(void)setNumberOfLines:(int)numberOfLines {
    
    
    if (numberOfLines != _numberOfLines) {
        
        _numberOfLines = numberOfLines;
        [self setNeedsDisplay];
    
    }
}

-(void)setLineHeight:(CGFloat)lineHeight {
    
    if (lineHeight != _lineHeight) {
        
        _lineHeight = lineHeight;
        [self setNeedsDisplay];

    }
}

-(void)setText:(NSString *)text {
      
    if (text != _text) {
        
        if (_text) {
            
            [_text release];
            _text = nil;
        }
        
        _text = [text retain];
        [self setNeedsDisplay];

    }
}


-(void)setFont:(UIFont *)font {

    if (font != _font) {
        
        if (_font) {
            
            [_font release];
            _font = nil;
            
        }
        
        _font = [font retain];
        self._lineHeight = _font.lineHeight;
        [self setNeedsDisplay];
        
    }
}


-(void)setFontColor:(UIColor *)fontColor {
    
    if (fontColor != _fontColor) {
        
        if (_fontColor) {
            
            [_fontColor release];
            _fontColor = nil;
            
        }
        
        _fontColor = [fontColor retain];
        [self setNeedsDisplay];
    }
    
}
- (void)setFontHighlightColor:(UIColor *)fontHighlightColor {
    if (fontHighlightColor != _fontHighlightColor) {
        if (_fontHighlightColor) {
            [_fontHighlightColor release];
            _fontHighlightColor = nil;
        }
        _fontHighlightColor = [fontHighlightColor retain];
        [self setNeedsDisplay];
    }
}

-(void)setLimitToNumberOfLines:(BOOL)limitToNumberOfLines {
    
    if (_limitToNumberOfLines != limitToNumberOfLines) {
        
        _limitToNumberOfLines = limitToNumberOfLines;
        [self setNeedsDisplay];
        
    }
    
}


-(void)setResizeToFitText:(BOOL)resizeToFitText {
    
    
    if (_shouldResizeToFit != resizeToFitText) {
        
        _shouldResizeToFit = resizeToFitText;
        [self setNeedsDisplay];
    }
    
}


-(void)setTextAlignment:(MTLabelTextAlignment)textAlignment {
    
    if (_textAlignment != textAlignment) {
        
        _textAlignment = textAlignment;
        [self setNeedsDisplay];
        
    }
    
}


#pragma mark - Getters


-(NSString *)text {
    
    return _text;
    
}

-(UIFont *)font {
    
    return _font;
}

-(CGFloat)lineHeight {
    
    return _lineHeight;
}


-(int)numberOfLines {
    
    return _numberOfLines;
}

-(UIColor *)fontColor {
    
    return _fontColor;
}

-(BOOL)limitToNumberOfLines {
    
    return _limitToNumberOfLines;
}

-(BOOL)resizeToFitText {
    
    return _shouldResizeToFit;
}

-(MTLabelTextAlignment)textAlignment {
    
    return _textAlignment;
}

#pragma mark - Object lifecycle

- (void)setup {
    _textHeight = 0;
    self._font = [UIFont systemFontOfSize:DEFAULT_FONT_SIZE];
    self._lineHeight = _font.lineHeight;
    self._textAlignment = MTLabelTextAlignmentLeft;      
    [self setOpaque:NO];
}
-(id)init {
    
    self = [super init];
    
    if (self) {
        [self setup];
    }    
    return self;
}

-(id)initWithFrame:(CGRect)frame {
    
    self = [super initWithFrame:frame];
    
    if (self) {
        [self setup];
    }
    return self;
}

- (id)initWithFrame:(CGRect)frame andText:(NSString *)text {
    
    self = [super initWithFrame:frame];
    
    if (self) {
        [self setup];
        self._text = text;
    }
    return self;
}
- (id)initWithCoder:(NSCoder *)aDecoder {
    self = [super initWithCoder:aDecoder];
    if (self) {
        [self setup];
    }
    return self;
}

-(id)initWithText:(NSString *)text {
    
    self = [super init];
    
    if (self) {
        [self setup];
        self._text = text;
    }
    return self;
}

+(id)label {

    return [[[MTLabel alloc] init] autorelease];

}

+(id)labelWithFrame:(CGRect)frame andText:(NSString *)text {
    
    return [[[MTLabel alloc] initWithFrame:frame andText:text] autorelease];
    
}


+(id)labelWithText:(NSString *)text {
    
    return [[[MTLabel alloc] initWithText:text] autorelease];
    
}


#pragma mark - Drawing

-(void)drawTransparentBackground {
    
    [self setBackgroundColor:[UIColor clearColor]];
    
}

- (CGFloat)textOffsetForLine:(CTLineRef)line inRect:(CGRect)rect {
    CGFloat x;
    
    switch (_textAlignment) {
            
        case MTLabelTextAlignmentLeft: {
            double offset = CTLineGetPenOffsetForFlush(line, 0, rect.size.width);
            x = offset;
            break;
        }
        case MTLabelTextAlignmentCenter: {
            double offset = CTLineGetPenOffsetForFlush(line, 0.5, rect.size.width);
            x = offset;
            break;
        }
        case MTLabelTextAlignmentRight: {
            
            double offset = CTLineGetPenOffsetForFlush(line, 2, rect.size.width);
            x = offset;
            break;
        }
        default:
            x = 0;
            break;
    }

    return x;
}
- (void)drawTextInRect:(CGRect)rect inContext:(CGContextRef)context {
    
    if (!_text) {
        return;
    }
    
    //Create a CoreText font object with name and size from the UIKit one
    CTFontRef font = CTFontCreateWithName((CFStringRef)_font.fontName , 
                                          _font.pointSize, 
                                          NULL);
    
    //Setup the attributes dictionary with font and color
    NSDictionary *attributes = [NSDictionary dictionaryWithObjectsAndKeys:
                                (id)font, (id)kCTFontAttributeName,
                                _fontColor.CGColor, kCTForegroundColorAttributeName,
                                nil];
    
    NSAttributedString *attributedString = [[[NSAttributedString alloc] 
                                             initWithString:_text 
                                             attributes:attributes] autorelease];
    
    CFRelease(font);
    
    //Create a TypeSetter object with the attributed text created earlier on
    CTTypesetterRef typeSetter = CTTypesetterCreateWithAttributedString((CFAttributedStringRef)attributedString);
    
    //Start drawing from the upper side of view (the context is flipped, so we need to grab the height to do so)
    CGFloat y = self.bounds.origin.y + self.bounds.size.height - _font.ascender;
    
    BOOL shouldDrawAlong = YES;
    int count = 0;
    CFIndex currentIndex = 0;
    
    _textHeight = 0;

    //Start drawing lines until we run out of text
    while (shouldDrawAlong) {
        
        //Get CoreText to suggest a proper place to place the line break
        CFIndex lineLength = CTTypesetterSuggestLineBreak(typeSetter, 
                                                          currentIndex, 
                                                          self.bounds.size.width);
        
        //Create a new line with from current index to line-break index
        CFRange lineRange = CFRangeMake(currentIndex, lineLength);
        CTLineRef line = CTTypesetterCreateLine(typeSetter, lineRange);
        
        //Create a new CTLine if we want to justify the text
        if (_textAlignment == MTLabelTextAlignmentJustify) {
            
            CTLineRef justifiedLine = CTLineCreateJustifiedLine(line, 1.0, self.bounds.size.width);
            CFRelease(line); line = nil;
            
            line = justifiedLine;
        }
        
        CGFloat x = [self textOffsetForLine:line inRect:self.bounds];
                
        // Draw highlight if color has been set
        if (_fontHighlightColor != nil) {
            CGContextSetFillColorWithColor(context, _fontHighlightColor.CGColor);
            CGRect lineRect = CTLineGetTypographicBoundsAsRect(line, CGPointMake(x, y));// + (self._lineHeight - self._font.pointSize) / 2));
            
            lineRect = CGRectIntegral(lineRect);
            lineRect = CGRectInset(lineRect, -1, -1);
            lineRect.origin.y -= 1;

            NSString *substring = [_text substringWithRange:NSMakeRange(lineRange.location, lineRange.length)];

            substring = [substring stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];
            if (0 < [substring length]) {

                CGContextFillRect(context, lineRect);
            }
        }
        //Setup the line position
        CGContextSetTextPosition(context, x, y);
        CTLineDraw(line, context);
                
        //Check to see if our index didn't exceed the text, and if should limit to number of lines
        if ((currentIndex + lineLength >= [_text length]) &&
            !(_limitToNumberOfLines && count < _numberOfLines-1) )    {    
            shouldDrawAlong = NO;
            
        }
        
        count++;
        CFRelease(line);

        CGFloat minFontSizeChange = 1;
        y -= _lineHeight;
        
        currentIndex += lineLength;
        _textHeight  += _lineHeight;
        
        if (_adjustSizeToFit && _font.pointSize > _minimumFontSize) {

            if (self.bounds.size.height < _textHeight) {
                
                NSString *fontName = _font.fontName;
                CGFloat pointSize = _font.pointSize;
                CGFloat lineHeightRatio = self._lineHeight / pointSize;
                CGFloat newPointSize = pointSize - minFontSizeChange;
                
                // Make sure newPointSize is not less than the _minimumFontSize
                newPointSize = newPointSize < _minimumFontSize ? _minimumFontSize : newPointSize;
                
                self._font = [UIFont fontWithName:fontName size:newPointSize];
                self._lineHeight = roundf(newPointSize * lineHeightRatio);

                CGContextClearRect(context, self.bounds);
                CFRelease(typeSetter);

                return [self drawTextInRect:self.bounds inContext:context];
            }
        }
    }
    
    CFRelease(typeSetter);

}
- (void)drawRect:(CGRect)rect {

    CGContextRef context = UIGraphicsGetCurrentContext();    

    //Grab the drawing context and flip it to prevent drawing upside-down
    CGContextSetTextMatrix(context, CGAffineTransformIdentity);
    CGContextTranslateCTM(context, 0, self.bounds.size.height);
    CGContextScaleCTM(context, 1.0, -1.0);
    
    CGContextSaveGState(context);

    CGColorRef colorRef = CGColorCreate(CGColorSpaceCreateDeviceRGB(), CGColorGetComponents([_fontColor CGColor]));
    CGContextSetShadowWithColor(context, CGSizeMake(self.shadowOffset, self.shadowOffset), 5, colorRef);
    
    [self drawTextInRect:rect inContext:context];
    
    
    if (_shouldResizeToFit && self.frame.size.height < _textHeight) {
        
        [self setFrame:CGRectMake(self.frame.origin.x, 
                                  self.frame.origin.y, 
                                  self.frame.size.width, 
                                  _textHeight)];
        
        // Notify delegate that we did change frame
        [delegate labelDidChangeFrame:self.frame];
        
        // Ugly hack to avoid content being stretched
        [self performSelector:@selector(setNeedsDisplay) withObject:nil afterDelay:0.0001];
    }
    CGContextRestoreGState(context);
    [super drawRect:self.bounds];
} 


#pragma mark - Memory managment

- (void)dealloc {
    
    [_text release]; _text = nil;
    [_fontColor release]; _fontColor = nil;
    [_fontHighlightColor release], _fontHighlightColor = nil;
    [_font release]; _font = nil;
    
    [super dealloc];
}

@end
