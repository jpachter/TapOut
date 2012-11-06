//
//  ClassicViewController.h
//  TapOut
//
//  Created by CSE483W on 11/5/12.
//  Copyright (c) 2012 CSE483W. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ClassicViewController : UIViewController{
    //int arrindex;
    //int score;
    //int arry[30];
    //NSTimer *classictimer;
   // NSInteger gameState;
}
//property can be used out of class.
//@property (weak, nonatomic) IBOutlet UIView *gameover;
//@property (weak, nonatomic) IBOutlet UILabel *gameoverlabel;
//@property (weak, nonatomic) IBOutlet UIButton *goback;
//@property (weak, nonatomic) IBOutlet UIButton *replay;

@property (weak, nonatomic) IBOutlet UIButton *redbutton;
@property (weak, nonatomic) IBOutlet UIButton *yellowbutton;
@property (weak, nonatomic) IBOutlet UIButton *bluebutton;
@property (weak, nonatomic) IBOutlet UIButton *greenbutton;

//@property (weak, nonatomic) IBOutlet UIButton *button11;
//@property (weak, nonatomic) IBOutlet UIButton *button22;
//@property (weak, nonatomic) IBOutlet UIButton *button33;
//@property (weak, nonatomic) IBOutlet UIButton *button44;

@property (weak, nonatomic) IBOutlet UILabel *scoreLabel;

- (IBAction)button1:(id)sender;
- (IBAction)button2:(id)sender;
- (IBAction)button3:(id)sender;
- (IBAction)button4:(id)sender;

@property (weak, nonatomic) IBOutlet UILabel *clickwhat;

//@property (nonatomic) NSInteger gameState;

@end
