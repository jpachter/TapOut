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
    
    int score;
    int arry[40];
    
    int arrindex;
    int playerindex;
    int roundindex;
    
    NSTimer *classictimer;
    NSTimer *myTimer;
    NSInteger gameState;
   // Memory *memory;
    
}

-(void) buttonFade:(UIButton*) button;
-(void) buttonReturn:(UIButton*) button;

@property (weak, nonatomic) IBOutlet UIView *GameOver;
//@property (weak, nonatomic) IBOutlet UILabel *GameoverLabel;
//@property (weak, nonatomic) IBOutlet UIButton *GoBack;
//@property (weak, nonatomic) IBOutlet UIButton *Replay;

@property (weak, nonatomic) IBOutlet UIButton *RedButton;
@property (weak, nonatomic) IBOutlet UIButton *YellowButton;
@property (weak, nonatomic) IBOutlet UIButton *BlueButton;
@property (weak, nonatomic) IBOutlet UIButton *GreenButton;

@property (weak, nonatomic) IBOutlet UILabel *ScoreLabel;
@property (weak, nonatomic) IBOutlet UILabel *RoundLabel;
@property (weak, nonatomic) IBOutlet UILabel *ArrindexLabel;

@property (weak, nonatomic) UIAlertView *alert;

-(IBAction)gameButtonClicked:(id)sender;

-(IBAction) goToMain:(id)sender;

- (void)alertOKCancelAction;
- (void)alertView:(UIAlertView *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex;

//-(IBAction)GobackButton:(id)sender;
//-(IBAction)ReplayButton:(id)sender;

@property (weak, nonatomic) IBOutlet UILabel *ClickWhat;

@property (nonatomic) NSInteger gameState;

@end
