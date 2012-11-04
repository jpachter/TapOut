//
//  ClassicViewController.h
//  appgame
//
//  Created by CSE483W on 11/2/12.
//  Copyright (c) 2012 CSE483W. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ClassicViewController : UIViewController{
    
    //Private variables, getters and setters are not implicitly declared.
    //These are only accessible within the class.
    int arrindex;
    int score;
    int arry[30];
    NSTimer *classictimer;
    NSInteger gameState;
}

//These properties will be '@synthesize' in the implementation. Setters and getters are
//implicitly created and we can then access them from outside of the class.
@property (weak, nonatomic) IBOutlet UIView *gameover;
@property (weak, nonatomic) IBOutlet UILabel *gameoverlabel;
@property (weak, nonatomic) IBOutlet UIButton *goback;
@property (weak, nonatomic) IBOutlet UIButton *replay;

@property (weak, nonatomic) IBOutlet UIButton *redbutton;
@property (weak, nonatomic) IBOutlet UIButton *yellowbutton;
@property (weak, nonatomic) IBOutlet UIButton *bluebutton;
@property (weak, nonatomic) IBOutlet UIButton *greenbutton;

@property (weak, nonatomic) IBOutlet UILabel *scoreLabel;

@property (weak, nonatomic) IBOutlet UILabel *clickwhat;

@property (nonatomic) NSInteger gameState;

- (IBAction)button1:(id)sender;
- (IBAction)button2:(id)sender;
- (IBAction)button3:(id)sender;
- (IBAction)button4:(id)sender;

@end
