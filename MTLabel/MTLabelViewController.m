//
//  MTLabelViewController.m
//  MTLabel
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

#import "MTLabelViewController.h"
#import "MTLabel.h"
#import <QuartzCore/QuartzCore.h>

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

    MTLabel *label1 = [[[MTLabel alloc] initWithFrame:CGRectMake(20, 20, 250, 200) 
                                              andText:@"This is \na label with \ncustom line height"] autorelease];
    [label1 setFont:[UIFont boldSystemFontOfSize:14]];
    [label1 setTextAlignment:MTLabelTextAlignmentLeft];
    [label1 setLineHeight:22];
    [[label1 layer] setBorderWidth:3];
    
    [self.view addSubview:label1];

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
