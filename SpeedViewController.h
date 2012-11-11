//
//  SpeedViewController.h
//  TapOut
//
//  Created by CSE483W on 11/11/12.
//  Copyright (c) 2012 CSE483W. All rights reserved.
//
//
//  SpeedViewController.h
//  TapOut
//
//  Created by CSE483W on 11/11/12.
//  Copyright (c) 2012 CSE483W. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <QuartzCore/QuartzCore.h>
#import "Memory.h"

@interface SpeedViewController : UIViewController<UIAlertViewDelegate>{
    
    int score;
    int arry[40];
    
    int arrindex;
    int playerindex;
    int roundindex;
    
    int timercount;
    
    NSTimer *classictimer;
    NSTimer *myTimer;
    NSTimer *Timer1;
    NSTimer *Timer2;
    NSInteger gameState;
    // Memory *memory;
    
}

-(void) buttonFade:(UIButton*) button;
-(void) buttonReturn:(UIButton*) button;

@property (weak, nonatomic) IBOutlet UIButton *RedButton;
@property (weak, nonatomic) IBOutlet UIButton *YellowButton;
@property (weak, nonatomic) IBOutlet UIButton *BlueButton;
@property (weak, nonatomic) IBOutlet UIButton *GreenButton;

@property (weak, nonatomic) IBOutlet UILabel *ScoreLabel;
@property (weak, nonatomic) IBOutlet UILabel *RoundLabel;
@property (weak, nonatomic) IBOutlet UILabel *PlayerIndex;

@property (weak, nonatomic) UIAlertView *alert;

-(IBAction)gameButtonClicked:(id)sender;

-(IBAction) goToMain:(id)sender;

- (void)alertOKCancelAction;
- (void)alertView:(UIAlertView *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex;

//@property (weak, nonatomic) IBOutlet UILabel *LeftTime;
@property (weak,nonatomic) IBOutlet UILabel *ClickWhat;
@property (weak,nonatomic) IBOutlet UILabel *ReminingTime;

@property (nonatomic) NSInteger gameState;


@end

