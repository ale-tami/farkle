//
//  DieLabel.m
//  Farkle
//
//  Created by Alejandro Tami on 30/07/14.
//  Copyright (c) 2014 Alejandro Tami. All rights reserved.
//

#import "DieLabel.h"

@implementation DieLabel

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
    }
    return self;
}

-(IBAction)onTapped:(id)sender
{
    [self.delegate didChooseDie:sender];//or self, it's the same
}

- (void)didChooseDie:(id)dieLabel
{
    
    
    
//    if (!self.onHold) {
//        self.onHold = YES;
//        self.backgroundColor = [UIColor greenColor];
//    } else {
//        self.onHold = NO;
//        self.backgroundColor = [UIColor lightGrayColor];
//    }
//    
}

-(void)roll
{
        int number = arc4random_uniform(6)+1;
        self.text = [NSString stringWithFormat:@"%i",number];
}

@end
