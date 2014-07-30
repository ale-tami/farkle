//
//  ViewController.m
//  Farkle
//
//  Created by Alejandro Tami on 30/07/14.
//  Copyright (c) 2014 Alejandro Tami. All rights reserved.
//

#import "ViewController.h"
#import "DieLabel.h"

typedef enum {
    PLAYER_1 = 1,
    PLAYER_2 = 2
} Player;


@interface ViewController ()<DieLabelDelegate>

@property (weak, nonatomic) IBOutlet DieLabel *dieLabel1;
@property (weak, nonatomic) IBOutlet DieLabel *dieLabel2;
@property (weak, nonatomic) IBOutlet DieLabel *dieLabel3;
@property (weak, nonatomic) IBOutlet DieLabel *dieLabel4;
@property (weak, nonatomic) IBOutlet DieLabel *dieLabel5;
@property (weak, nonatomic) IBOutlet DieLabel *dieLabel6;
@property (weak, nonatomic) IBOutlet UILabel *player1Score;
@property (weak, nonatomic) IBOutlet UILabel *player2Score;

@property NSMutableArray *dice;
@property int userScoreInt;

@end

@implementation ViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.dieLabel1.delegate = self;
    self.dieLabel2.delegate = self;
    self.dieLabel3.delegate = self;
    self.dieLabel4.delegate = self;
    self.dieLabel5.delegate = self;
    self.dieLabel6.delegate = self;

    self.dice = [[NSMutableArray alloc] init];

}

- (void)didChooseDie:(UITapGestureRecognizer*)sender
{
    DieLabel * dl = (DieLabel*) sender.view;
    if (![self.dice containsObject:dl]){
        dl.backgroundColor = [UIColor greenColor];
        [self.dice addObject:dl];
    }
}

- (IBAction)onBankButtonPressed:(id)sender {
}




- (IBAction)onRollButtonPressed:(id)sender
{
    for (DieLabel *die in self.view.subviews){
        
        if (![self.dice containsObject:die] && [die isKindOfClass:[DieLabel class]]) {
            [die roll];
        }
        
    }
}

@end
