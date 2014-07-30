//
//  DieLabel.h
//  Farkle
//
//  Created by Alejandro Tami on 30/07/14.
//  Copyright (c) 2014 Alejandro Tami. All rights reserved.
//

#import <UIKit/UIKit.h>


@protocol DieLabelDelegate

- (void)didChooseDie:(id)dieLabel;

@end

@interface DieLabel : UILabel

@property id <DieLabelDelegate> delegate;

- (void) roll;

@end
