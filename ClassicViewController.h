//
//  ClassicViewController.h
//  TapOut
//
//  Created by CSE483W on 11/5/12.
//  Copyright (c) 2012 CSE483W. All rights reserved.
//

#import <UIKit/UIKit.h>


@interface ClassicViewController : UIViewController{
    
    int score;
    int arry[30];
    
    int arrindex;
    int playerindex;
    int roundindex;
    
    NSTimer *classictimer;
    NSTimer *myTimer;
    NSInteger gameState;
    //Memory *memorystruct;
    
}

@property (weak, nonatomic) IBOutlet UIView *GameOver;
//@property (weak, nonatomic) IBOutlet UILabel *GameoverLabel;
//@property (weak, nonatomic) IBOutlet UIButton *GoBack;
//@property (weak, nonatomic) IBOutlet UIButton *Replay;

@property (weak, nonatomic) IBOutlet UIButton *RedButton;
@property (weak, nonatomic) IBOutlet UIButton *YellowButton;
@property (weak, nonatomic) IBOutlet UIButton *BlueButton;
@property (weak, nonatomic) IBOutlet UIButton *GreenButton;

@property (weak, nonatomic) IBOutlet UIButton *Button11;
@property (weak, nonatomic) IBOutlet UIButton *Button22;
@property (weak, nonatomic) IBOutlet UIButton *Button33;
@property (weak, nonatomic) IBOutlet UIButton *Button44;

@property (weak, nonatomic) IBOutlet UILabel *ScoreLabel;
@property (weak,nonatomic) IBOutlet UILabel *RoundLabel;
@property (weak, nonatomic) IBOutlet UILabel *ArrindexLabel;

-(IBAction)Button1:(id)sender;
-(IBAction)Button2:(id)sender;
-(IBAction)Button3:(id)sender;
-(IBAction)Button4:(id)sender;

//-(IBAction)GobackButton:(id)sender;
//-(IBAction)ReplayButton:(id)sender;

@property (weak, nonatomic) IBOutlet UILabel *ClickWhat;

@property (nonatomic) NSInteger gameState;

@end
