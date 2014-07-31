//
//  ViewController.m
//  Farkle
//
//  Created by Alejandro Tami on 30/07/14.
//  Copyright (c) 2014 Alejandro Tami. All rights reserved.
//

#import "ViewController.h"
#import "DieLabel.h"
#import "ScoreCalculator.h"

typedef enum {
    PLAYER_1 = 1,
    PLAYER_2 = 2,
    NONE
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
@property (weak, nonatomic) IBOutlet UILabel *partialScore;

@property NSMutableArray *dice;
@property NSMutableArray *rolledDice;
@property Player playerTurn;
//@property int partialScoreInt; BAD practice use label to get values naughty Ale


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
    self.rolledDice = [NSMutableArray  arrayWithObjects:self.dieLabel1,
                                                        self.dieLabel2,
                                                        self.dieLabel3,
                                                        self.dieLabel4,
                                                        self.dieLabel5,
                                                        self.dieLabel6,
                                                        nil];
    
    [self changeTurn];

}

- (void)didChooseDie:(UITapGestureRecognizer*)sender
{
//    DieLabel * dl = (DieLabel*) sender.view;
//    if (![self.dice containsObject:dl]){
//        dl.backgroundColor = [UIColor greenColor];
//        [self.dice addObject:dl];
//    }
}

- (IBAction)onBankButtonPressed:(id)sender
{
    
}


- (IBAction)onRollButtonPressed:(id)sender
{
    for (DieLabel *die in self.view.subviews){
        
        if (![self.dice containsObject:die] && [die isKindOfClass:[DieLabel class]]) {
            [die roll];
        }
        
    }
    self.partialScore.text = [NSString stringWithFormat:@"%i", [self calculatePoints] ];
}

//Dice combination	Score
//Each 1	100
//Each 5	50
//Three 1s	1000
//Three 2s	200
//Three 3s	300
//Three 4s	400
//Three 5s	500
//Three 6s	600

- (int) calculatePoints
{
    int oneCounter = 0;
    int twoCounter= 0;
    int threeCounter = 0;
    int fourCounter = 0;
    int fiveCounter = 0;
    int sixCounter = 0;
    int points = 0;
    // Count amount of dice of each type
    for (DieLabel *die in self.rolledDice){
        
        switch ([die.text intValue]) {
            case 1:
                oneCounter++;
                break;
            case 2:
                twoCounter++;
                break;
            case 3:
                threeCounter++;
                break;
            case 4:
                fourCounter++;
                break;
            case 5:
                fiveCounter++;
                break;
            case 6:
                sixCounter++;
                break;
        }
        
    }
    // start adding points according to the table above
    if (oneCounter >= 3) {
        points += 1000;
        [self markDiceWithValue:1 inQuantity:3];
    } else if (oneCounter > 1){
        points += oneCounter * 100;
        [self markDiceWithValue:1 inQuantity:oneCounter];
    }
    
    if (fiveCounter >= 3) {
        points += 500;
        [self markDiceWithValue:5 inQuantity:3];
    } else if (fiveCounter > 1){
        points += fiveCounter * 50;
        [self markDiceWithValue:5 inQuantity:fiveCounter];
    }
    
    if (threeCounter == 3) {
        points += 300;
        [self markDiceWithValue:3 inQuantity:threeCounter];
    }
    
    if (fourCounter == 3) {
        points += 400;
        [self markDiceWithValue:4 inQuantity:fourCounter];
    }
    
    if (sixCounter == 3) {
        points += 600;
        [self markDiceWithValue:6 inQuantity:sixCounter];
    }
    
    return points;
    
}

- (void) markDiceWithValue: (int)value inQuantity: (int) qtty
{
    // We already know that the value exists, so I have to just mark the labels that have the value
    int counter = 0;
    NSMutableArray * auxArray = [NSMutableArray arrayWithArray: self.rolledDice];
    
    for ( DieLabel *die in self.rolledDice ) {
        if ([die.text intValue] == value && counter < qtty ) {
            [self.dice addObject:die];
            [auxArray removeObject:die];
             die.backgroundColor = [UIColor greenColor];
            counter++;
        }
        
    }
    self.rolledDice = auxArray;
}

- (void) changeTurn
{
    if (self.playerTurn == PLAYER_1 || self.playerTurn == NONE) {
        
        self.player1Score.textColor = [UIColor whiteColor];
        self.player1Score.backgroundColor = [UIColor redColor];
        self.player2Score.textColor = [UIColor blueColor];
        self.player2Score.backgroundColor = [UIColor whiteColor];
        
        self.player1Score.text = [NSString stringWithFormat:@"%i", [self.player1Score.text intValue] + [self.partialScore.text intValue] ];
        
    } else {
        self.player2Score.textColor = [UIColor whiteColor];
        self.player2Score.backgroundColor = [UIColor blueColor];
        self.player1Score.textColor = [UIColor redColor];
        self.player1Score.backgroundColor = [UIColor whiteColor];
        
        self.player2Score.text = [NSString stringWithFormat:@"%i", [self.player2Score.text intValue] + [self.partialScore.text intValue] ];

    }
    
    self.partialScore.text = @"Partial Score";
}

- (void) reset
{
    [self.dice removeAllObjects];
    [self.rolledDice removeAllObjects];
    self.rolledDice = [NSMutableArray  arrayWithObjects:self.dieLabel1,
                                         self.dieLabel2,
                                         self.dieLabel3,
                                         self.dieLabel4,
                                         self.dieLabel5,
                                         self.dieLabel6,
                                         nil];
   // self.partialScoreInt = 0;
    self.partialScore.text = nil;
    
}


@end
