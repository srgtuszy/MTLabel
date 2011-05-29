//
//  MTLabel.h
//  CustomLabelTest
//
//Copyright 2011 Michal Tuszynski
//
//Licensed under the Apache License, Version 2.0 (the "License");
//you may not use this file except in compliance with the License.
//You may obtain a copy of the License at
//
//http://www.apache.org/licenses/LICENSE-2.0
//
//Unless required by applicable law or agreed to in writing, software
//distributed under the License is distributed on an "AS IS" BASIS,
//WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
//See the License for the specific language governing permissions and
//limitations under the License.

#import <UIKit/UIKit.h>

typedef enum {
    
    MTLabelTextAlignmentLeft,
    MTLabelTextAlignmentCenter,
    MTLabelTextAlignmentRight,
    MTLabelTextAlignmentJustify
    
} MTLabelTextAlignment;


@interface MTLabel : UIView {
    
    int _numberOfLines;
    CGFloat _lineHeight;
    NSString *_text;
    UIColor *_fontColor;
    UIFont *_font;
    BOOL _limitToNumberOfLines;
    MTLabelTextAlignment _textAlignment;
    
}

@property (nonatomic, readwrite, setter = setNumberOfLines:, getter = numberOfLines) int _numberOfLines;
@property (nonatomic, readwrite, setter = setLineHeight:)    CGFloat _lineHeight;
@property (nonatomic, retain, setter = setText:, getter = text) NSString *_text;
@property (nonatomic, retain, setter = setFontColor:, getter = fontColor) UIColor *_fontColor;
@property (nonatomic, retain, setter = setFont:, getter = font) UIFont *_font;
@property (nonatomic, readwrite, setter = setLimitToNumberOfLines:, getter = limitToNumberOfLines) BOOL _limitToNumberOfLines;
@property (nonatomic, readwrite, setter = setTextAlignment:, getter = textAlignment) MTLabelTextAlignment _textAlignment;

-(id)initWithFrame:(CGRect)frame andText:(NSString *)text;
-(id)initWithText:(NSString *)text;
-(void)setText:(NSString *)text;
-(void)setLineHeight:(CGFloat)lineHeight;
-(void)setNumberOfLines:(int)numberOfLines;
-(void)setFont:(UIFont *)font;
-(void)setFontColor:(UIColor *)fontColor;
-(void)setLimitToNumberOfLines:(BOOL)limitToNumberOfLines;
-(void)setTextAlignment:(MTLabelTextAlignment)textAlignment;
-(void)resizeToFitText;
-(NSString *)text;
-(CGFloat)lineHeight;
-(UIColor *)fontColor;
-(UIFont *)font;
-(int)numberOfLines;
-(BOOL)limitToNumberOfLines;
-(MTLabelTextAlignment)textAlignment;


@end
