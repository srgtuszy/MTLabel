//
//  MTLabelViewController.m
//  MTLabel
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

#import "MTLabelViewController.h"
#import "MTLabel.h"

@implementation MTLabelViewController

- (void)dealloc
{
    [super dealloc];
}

- (void)didReceiveMemoryWarning
{
    // Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
    
    // Release any cached data, images, etc that aren't in use.
}

#pragma mark - View lifecycle


// Implement viewDidLoad to do additional setup after loading the view, typically from a nib.
- (void)viewDidLoad {
    [super viewDidLoad];
    
    MTLabel *label1 = [MTLabel labelWithFrame:CGRectMake(20, 20, 250, 200) 
                                      andText:@"This is a label with custom line height"];
    
    [label1 setFont:[UIFont boldSystemFontOfSize:14]];
    [label1 setTextAlignment:MTLabelTextAlignmentLeft];
    [label1 setLineHeight:25];
    
    [self.view addSubview:label1];
    
    MTLabel *label2 = [MTLabel labelWithFrame:CGRectMake(20, 150, 250, 70) 
                                      andText:@"This is a justified text example, with normal line height (from UIFont)"];
    [label2 setTextAlignment:MTLabelTextAlignmentJustify];
    [label2 setFont:[UIFont boldSystemFontOfSize:15]];
    [self.view addSubview:label2];
    
    MTLabel *label3 = [MTLabel labelWithFrame:CGRectMake(20, 240, 250, 1) 
                                      andText:@"This label was resized to fit text inside it"];
    [label3 setTextAlignment:MTLabelTextAlignmentCenter];
    [label3 setFont:[UIFont systemFontOfSize:12]];
    [label3 setResizeToFitText:YES];
    [self.view addSubview:label3];

    MTLabel *label4 = [MTLabel labelWithFrame:CGRectMake(20, 270, 250, 60) 
                                      andText:@"This label is highlighted, has a custom line height, and adjusts font size to fit inside the label."];
    [label4 setLineHeight:22];
    [label4 setFont:[UIFont fontWithName:@"Helvetica" size:30]];
    [label4 setAdjustSizeToFit:YES];
    [label4 setMinimumFontSize:15];
    [label4 setFontHighlightColor:[[UIColor orangeColor] colorWithAlphaComponent:0.5]];
    [self.view addSubview:label4];
}


- (void)viewDidUnload
{
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    // Return YES for supported orientations
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

@end
