//
//  speedViewController.m
//  TapOut
//
//  Created by CSE483W on 11/7/12.
//  Copyright (c) 2012 CSE483W. All rights reserved.
//
#define GAME_RUNNING 1
#define GAME_OVER 2

#import "SpeedViewController.h"
#import "ViewController.h"
#import <time.h>

#import <unistd.h>


@implementation SpeedViewController

@synthesize memStruct;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    //Game startup. Initialize and begin.
    memStruct = [[Memory alloc] init];
    [self startGame];
    [self playRound];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)startGame {
    //initialize everything
    
    playerScore=0;
    arrIndex=0;
    playerIndex=0;
    roundIndex=0;
    
    [memStruct build];
}

- (void)playRound {

    //disable all colored buttons when illuminate
    //[self disableButtons];
        roundIndex++;
    _RoundLabel.text=[NSString stringWithFormat:@"Round: %i",roundIndex];
    
    _ReminingTime.text=[NSString stringWithFormat:@"%.2f",.70*(double)roundIndex];
    
        playerIndex=0;
    //illuminate button --- read value in arr from 0 to round-1
    arrIndex=0;
    
    //control the illumination per round
    [self disableButtons];
    myTimer=[NSTimer scheduledTimerWithTimeInterval:.7 target:self selector:@selector(illumination:) userInfo:nil repeats:YES];

}

- (void)disableButtons {
    //disable all buttons when illuminate
    
    _RedButton.enabled=NO;
    _YellowButton.enabled=NO;
    _GreenButton.enabled=NO;
    _BlueButton.enabled=NO;
}

- (void)enableButtons {
    //enable buttons after illuminate
    
    _RedButton.enabled=YES;
    _YellowButton.enabled=YES;
    _GreenButton.enabled=YES;
    _BlueButton.enabled=YES;
}

- (void)illumination:(NSTimer *) timer {
    //illuminate buttons whose values are read from memStruct
    
    UIButton *button;
    int index=[memStruct getButton:arrIndex];
    
    switch((NSInteger)index){
        case 1:
            button = _RedButton;
            break;
        case 2:
            button = _YellowButton;
            break;
        case 3:
            button = _GreenButton;
            break;
        case 4:
            button = _BlueButton;
            break;
    }
    
    [self buttonFade: button];
    [self performSelector:@selector(buttonReturn:) withObject:button afterDelay:.35];
    
    arrIndex+=1;
    if(arrIndex==roundIndex)  //stop the calling of illumination.
    {
        [myTimer invalidate];
        [self performSelector:@selector(enableButtons) withObject:nil afterDelay:.7];
        timercount=.7*roundIndex;
        [self performSelector:@selector(startTimer) withObject:nil afterDelay:.7];
    }
}

- (void)startTimer {
        Timer2=[NSTimer scheduledTimerWithTimeInterval:.01 target:self selector:@selector(TimerCount:) userInfo:nil repeats:YES];
}


-(void) TimerCount:(NSTimer *) timer{
    _ReminingTime.text=[NSString stringWithFormat:@"%.2f",timercount];
    _PlayerLabel.text=[NSString stringWithFormat:@"Player: %i",playerIndex];
    timercount-=.01;
    if(timercount<0){
        
        [Timer2 invalidate];
        if(playerIndex==roundIndex){
            [self roundOver];
            [self performSelector:@selector(playRound) withObject:nil afterDelay:1.5];
        }
        else{
            [self popupGameOver];
        }
      // else{
     //       [self popupGameOver];
       // }
    }
    
}

- (void)buttonFade:(UIButton*) button {
    
    button.selected = TRUE;
    CATransition *transition = [CATransition animation];
    transition.duration = .35;
    transition.type = kCATransitionFade;
    transition.delegate = self;
    [button.layer addAnimation:transition forKey:nil];
    button.selected = TRUE;
}

- (void)buttonReturn:(UIButton*) button{
    
    button.selected = FALSE;
    CATransition *transition = [CATransition animation];
    transition.duration = .35;
    transition.type = kCATransitionFade;
    transition.delegate = self;
    [button.layer addAnimation:transition forKey:nil];
    button.selected = FALSE;
}

- (IBAction)gameButtonClicked:(id) sender {
    //after illumination, player repeats sequence
    
    //know which button the users have clicked
    NSInteger playerClick;
    switch ( ((UIButton*)sender).tag ){
            
        case 1:
            playerClick = 1;
            break;
        case 2:
            playerClick = 2;
            break;
        case 3:
            playerClick = 3;
            break;
        case 4:
            playerClick = 4;
            break;
    }
    
    //if click right, playerScore++, playerIndex++
    
    if([memStruct getButton:playerIndex] == playerClick){
        playerIndex++;
        if(playerIndex<roundIndex){
            _ScoreLabel.text=[NSString stringWithFormat:@"Score: %i",++playerScore];

        }
        else{
            [Timer2 invalidate];
            [self roundOver];
            [self performSelector:@selector(playRound) withObject:nil afterDelay:1.5];
        }
    }
    else{
        [Timer2 invalidate];
        [self popupGameOver];
    }
}

- (void)popupGameOver {
    // open a popup with return and retry buttons
    if(myTimer){
        
    
    UIAlertView *popup = [[UIAlertView alloc] initWithTitle:@"Game Over" message:@"Play again?" delegate:self cancelButtonTitle:@"Main Menu" otherButtonTitles:@"Retry", nil];
    [popup show];
    }
}


- (void)roundOver {
    // open a popup with return and retry buttons
    UIAlertView *alert = [[UIAlertView alloc]
                          initWithTitle: @"TapOut"
                          message: [NSString stringWithFormat:@"\nRound %i Complete!!", playerIndex]
                          delegate: nil
                          cancelButtonTitle:nil
                          otherButtonTitles:nil];
    [alert show];
    
    [self performSelector:@selector(dismissAfterDelay:) withObject:alert afterDelay:1.5];
    
}

- (void)dismissAfterDelay: (UIAlertView *) alert
{
    [alert dismissWithClickedButtonIndex:0 animated:YES];
}


- (void)alertView:(UIAlertView *)popupAction clickedButtonAtIndex:(NSInteger)buttonIndex {
    // the user clicked one of the buttons on the game over popup
    if (buttonIndex == 0)
    {
        [self goToMain:nil];
    }
    else
    {
        //Rest
        [self startGame];
        _ScoreLabel.text=[NSString stringWithFormat:@"Score: %i",playerScore];
        _RoundLabel.text=[NSString stringWithFormat:@"Round: %i",roundIndex];
        [self playRound];
    }
}

- (IBAction)goToMain:(id) sender {
    //return to main menu view
    
    [Timer2 invalidate];
    Timer2 = nil;
    [myTimer invalidate];
    myTimer = nil;
    ViewController *main = [[ViewController alloc] initWithNibName: nil bundle:nil];
    [self presentViewController:main animated:YES completion:nil];

}

@end
