//
//  ClassicViewController.m
//  TapOut
//
//  Created by CSE483W on 11/7/12.
//  Copyright (c) 2012 CSE483W. All rights reserved.
//
#define GAME_RUNNING 1
#define GAME_OVER 2

#import "ClassicViewController.h"
#import "ViewController.h"
#import <time.h>

@implementation ClassicViewController

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
    roundIndex=1;
    
    [memStruct build];
}

- (void)playRound {
    
    //disable all colored buttons when illuminate
    [self disableButtons];
    
    _RoundLabel.text=[NSString stringWithFormat:@"Round: %i",roundIndex];
    
    //illuminate button --- read value in arr from 0 to round-1
    arrIndex=0;
    
    //control the illumination per round
    myTimer=[NSTimer scheduledTimerWithTimeInterval:1 target:self selector:@selector(illumination:) userInfo:nil repeats:YES];
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
    [self performSelector:@selector(buttonReturn:) withObject:button afterDelay:.5];
    
    arrIndex+=1;
    if(arrIndex==roundIndex)  //stop the calling of illumination.
    {
        [myTimer invalidate];
        [self performSelector:@selector(enableButtons) withObject:nil afterDelay:1];
    }
}

- (void)buttonFade:(UIButton*) button {
    
    button.selected = TRUE;
    CATransition *transition = [CATransition animation];
    transition.duration = .3;
    transition.type = kCATransitionFade;
    transition.delegate = self;
    [button.layer addAnimation:transition forKey:nil];
    button.selected = TRUE;
}

- (void)buttonReturn:(UIButton*) button{
    
    button.selected = FALSE;
    CATransition *transition = [CATransition animation];
    transition.duration = .3;
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
        
        _ScoreLabel.text=[NSString stringWithFormat:@"Score: %i",++playerScore];
        
        if(playerIndex == roundIndex-1){
            
            [self roundOver];
          
            //next round
            playerIndex = 0;
            roundIndex++;
            [self performSelector:@selector(playRound) withObject:nil afterDelay:1.5];
        }
        else
            playerIndex++;
    }
    else{
        //if player's click is wrong, game over
        [self popupGameOver];
    }
}

- (void)popupGameOver {
    // open a popup with return and retry buttons
    UIAlertView *popup = [[UIAlertView alloc] initWithTitle:@"Game Over" message:@"Play again?" delegate:self cancelButtonTitle:@"Main Menu" otherButtonTitles:@"Retry", nil];
    [popup show];
}

- (void)roundOver {
    // open a popup with return and retry buttons
    UIAlertView *alert = [[UIAlertView alloc]
                          initWithTitle: @"TapOut"
                          message: [NSString stringWithFormat:@"\nRound %i Complete!!", playerIndex+1]
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
        //Reset
        [self startGame];
        _ScoreLabel.text=[NSString stringWithFormat:@"Score: %i",playerScore];
        _RoundLabel.text=[NSString stringWithFormat:@"Round: %i",roundIndex];
        [self playRound];
    }
}

- (IBAction)goToMain:(id) sender {
    //return to main menu view
    
    [myTimer invalidate];
    myTimer = nil;
    ViewController *main = [[ViewController alloc] initWithNibName: nil bundle:nil];
    [self presentViewController:main animated:YES completion:nil];
}

@end
