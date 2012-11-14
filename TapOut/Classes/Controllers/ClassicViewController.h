//
//  ClassicViewController.h
//  TapOut
//
//  Created by CSE483W on 11/5/12.
//  Copyright (c) 2012 CSE483W. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <QuartzCore/QuartzCore.h>
#import "Memory.h"

@interface ClassicViewController : UIViewController <UIAlertViewDelegate>{
    
    int playerScore;    // increments when player touches correct color
    int playerIndex;    // increments when player touches a color (reset each round)
    int roundIndex;     // increments when player moves to next round
    int arrIndex;       // used for illuminating button sequence to player
    
    NSTimer *myTimer;   // timer for how long each button should be illuminated
}

@property Memory *memStruct;    // contains button sequence

// buttons on the classic screen
@property (weak, nonatomic) IBOutlet UIButton *RedButton;
@property (weak, nonatomic) IBOutlet UIButton *YellowButton;
@property (weak, nonatomic) IBOutlet UIButton *BlueButton;
@property (weak, nonatomic) IBOutlet UIButton *GreenButton;

// labels to display player's score and round
@property (weak, nonatomic) IBOutlet UILabel *ScoreLabel;
@property (weak, nonatomic) IBOutlet UILabel *RoundLabel;


- (void)startGame;
- (void)playRound;

- (void)disableButtons;
- (void)enableButtons;
- (void)illumination:(NSTimer *) timer;

- (void)buttonFade:(UIButton *) button;
- (void)buttonReturn:(UIButton *) button;

- (IBAction)gameButtonClicked:(id) sender;
- (void)popupGameOver;
- (void)alertView:(UIAlertView *) popupAction clickedButtonAtIndex:(NSInteger) buttonIndex;
- (IBAction)goToMain:(id) sender;

@end
