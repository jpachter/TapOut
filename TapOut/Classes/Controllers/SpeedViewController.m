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
    [self disableButtons];
    playerIndex=0;         //Player button index
    arrIndex=0;            //Read value in memStruct at arrIndex
    roundIndex++;          //Round

    _roundLabel.text=[NSString stringWithFormat:@"Round: %i",roundIndex];
    _scoreLabel.text=[NSString stringWithFormat:@"Score: %i",playerScore];
    _countdownLabel.text=[NSString stringWithFormat:@"%.2f",.70*(double)roundIndex];

    //control the illumination per round
    illuminationTimer=[NSTimer scheduledTimerWithTimeInterval:.7 target:self selector:@selector(illumination) userInfo:nil repeats:YES];

}

- (void)disableButtons {
    //disable all buttons before illuminate
    _redButton.enabled=NO;
    _yellowButton.enabled=NO;
    _greenButton.enabled=NO;
    _blueButton.enabled=NO;
}

- (void)enableButtons {
    //enable buttons after illuminate
    _redButton.enabled=YES;
    _yellowButton.enabled=YES;
    _greenButton.enabled=YES;
    _blueButton.enabled=YES;
}

- (void)illumination{
    //illuminate buttons whose values are read from memStruct
    
    UIButton *button;
    int index=[memStruct getButton:arrIndex++];
    
    switch((NSInteger)index){
        case 1:
            button = _redButton;
            break;
        case 2:
            button = _yellowButton;
            break;
        case 3:
            button = _greenButton;
            break;
        case 4:
            button = _blueButton;
            break;
    }
    
    [self buttonFade: button];
    [self performSelector:@selector(buttonReturn:) withObject:button afterDelay:.35];
    

    if(arrIndex==roundIndex)  //stop the calling of illumination.
    {
        [illuminationTimer invalidate];
        [self performSelector:@selector(enableButtons) withObject:nil afterDelay:.7];
        countDown=.7*roundIndex;
        [self performSelector:@selector(startTimer) withObject:nil afterDelay:.7];
    }
}

- (void)startTimer {
        countdownTimer=[NSTimer scheduledTimerWithTimeInterval:.01 target:self selector:@selector(doCountdown) userInfo:nil repeats:YES];
}


- (void) doCountdown{
    countDown-=.01;
    _countdownLabel.text=[NSString stringWithFormat:@"%.2f",countDown];
    
    if(countDown<0){
        _countdownLabel.text=[NSString stringWithFormat:@"0.00"];
        [countdownTimer invalidate];
        [self popupGameOver];
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
    
    if([memStruct getButton:playerIndex] == playerClick){
        playerIndex++;
        playerScore+=2;
        _scoreLabel.text=[NSString stringWithFormat:@"Score: %i",playerScore];

        if(playerIndex == roundIndex){
            [countdownTimer invalidate];
            [self roundOver];
            [self performSelector:@selector(playRound) withObject:nil afterDelay:1.5];
        }
    }
    else{
        [countdownTimer invalidate];
        [self popupGameOver];
    }
}

- (void)popupGameOver {
    // open a popup with return and retry buttons
    if(illuminationTimer){
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
        //Retry
        [self startGame];
        [self playRound];
    }
}

- (IBAction)goToMain:(id) sender {
    //return to main menu view
    
    [countdownTimer invalidate];
    countdownTimer = nil;
    [illuminationTimer invalidate];
    illuminationTimer = nil;
    ViewController *main = [[ViewController alloc] initWithNibName: nil bundle:nil];
    [self presentViewController:main animated:YES completion:nil];
}

@end
