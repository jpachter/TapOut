//
//  SpeedViewController.h
//  TapOut
//
//  Created by CSE483W on 11/15/12.
//  Copyright (c) 2012 CSE483W. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <QuartzCore/QuartzCore.h>
#import "Memory.h"

@interface SpeedViewController : UIViewController <UIAlertViewDelegate>{
    
    int playerScore;    // increments when player touches correct color
    int playerIndex;    // increments when player touches a color (reset each round)
    int roundIndex;     // increments when player moves to next round
    int arrIndex;       // used for illuminating button sequence to player
    double countDown;
    
    NSTimer *countdownTimer;
    NSTimer *illuminationTimer;   // timer for how long each button should be illuminated
}

@property Memory *memStruct;    // contains button sequence

// buttons on the speed screen
@property (weak, nonatomic) IBOutlet UIButton *redButton;
@property (weak, nonatomic) IBOutlet UIButton *yellowButton;
@property (weak, nonatomic) IBOutlet UIButton *blueButton;
@property (weak, nonatomic) IBOutlet UIButton *greenButton;

// labels to display player's score and round
@property (weak, nonatomic) IBOutlet UILabel *scoreLabel;
@property (weak, nonatomic) IBOutlet UILabel *roundLabel;
@property (weak, nonatomic) IBOutlet UILabel *countdownLabel;
@property (weak, nonatomic) IBOutlet UILabel *playerLabel;


- (void)startGame;
- (void)playRound;

- (void)disableButtons;
- (void)enableButtons;
- (void)illumination;
- (void) doCountdown;
- (void)buttonFade:(UIButton *) button;
- (void)buttonReturn:(UIButton *) button;

- (IBAction)gameButtonClicked:(id) sender;
- (void)popupGameOver;
- (void)roundOver;
- (void)dismissAfterDelay:(UIAlertView *) alert;
- (void)alertView:(UIAlertView *) popupAction clickedButtonAtIndex:(NSInteger) buttonIndex;
- (IBAction)goToMain:(id) sender;

@end
