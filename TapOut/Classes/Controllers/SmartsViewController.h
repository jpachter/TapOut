//
//  SmartsViewController.h
//  TapOut
//
//  Created by CSE483W on 11/5/12.
//  Copyright (c) 2012 CSE483W. All rights reserved.
//
#pragma mark PassTouch

@interface UIButton (PassTouch)
@end

@implementation UIButton (PassTouch)
- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    [super touchesBegan:touches withEvent:event];
    [self.nextResponder touchesBegan:touches withEvent:event];
}
- (void)touchesMoved:(NSSet *)touches withEvent:(UIEvent *)event
{
    [super touchesMoved:touches withEvent:event];
    [self.nextResponder touchesMoved:touches withEvent:event];
}
- (void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event
{
    [super touchesEnded:touches withEvent:event];
    [self.nextResponder touchesEnded:touches withEvent:event];
}
@end


#import <UIKit/UIKit.h>
#import <QuartzCore/QuartzCore.h>
#import "Memory.h"
#import "MyButton.h"

@interface SmartsViewController : UIViewController <UIAlertViewDelegate>{
    
    int playerScore;    // increments when player touches correct color
    int playerIndex;    // increments when player touches a color (reset each round)
    int roundIndex;     // increments when player moves to next round
    int arrIndex;       // used for illuminating button sequence to player
    Boolean rotated;
    NSTimer *myTimer;   // timer for how long each button should be illuminated
    NSTimer *fixer;   // timer for how long each button should be illuminated

    double degrees;
}

@property Memory *memStruct;    // contains button sequence

// buttons on the smarts screen
@property (weak, nonatomic) IBOutlet MyButton *RedButton;
@property (weak, nonatomic) IBOutlet MyButton *YellowButton;
@property (weak, nonatomic) IBOutlet MyButton *BlueButton;
@property (weak, nonatomic) IBOutlet MyButton *GreenButton;
@property (weak, nonatomic) IBOutlet UIView *buttons;

@property (weak, nonatomic) IBOutlet UIImageView *redd;


// labels to display player's score and round
@property (weak, nonatomic) IBOutlet UILabel *ScoreLabel;
@property (weak, nonatomic) IBOutlet UILabel *RoundLabel;


- (void)startGame;
- (void)playRound;

-(void)fixFrame;
- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event;
- (void)disableButtons;
- (void)enableButtons;
- (void)illumination:(NSTimer *) timer;
-(void)continueSpinning;

- (void)buttonFade:(UIButton *) button;
- (void)buttonReturn:(UIButton *) button;
- (IBAction)gameButtonClicked:(int) playerClick;
- (void)popupGameOver;
- (void)alertView:(UIAlertView *) popupAction clickedButtonAtIndex:(NSInteger) buttonIndex;
- (IBAction)goToMain:(id) sender;

@end
