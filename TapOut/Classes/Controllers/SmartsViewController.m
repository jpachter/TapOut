//
//  SmartsViewController.m
//  TapOut
//
//  Created by CSE483W on 11/7/12.
//  Copyright (c) 2012 CSE483W. All rights reserved.
//
#define GAME_RUNNING 1
#define GAME_OVER 2

#import "SmartsViewController.h"
#import "ViewController.h"
#import <time.h>

@implementation SmartsViewController

@synthesize memStruct;
@synthesize buttons;

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
    rotated = false;
    buttons.layer.anchorPoint = CGPointMake(0.5,0.7);
    [self continueSpinning];

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
    //[self disableButtons];
    
    _RoundLabel.text=[NSString stringWithFormat:@"round: %i",roundIndex];
    
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
        //CGSize sz = buttons.bounds.size;
        // Anchorpoint coords are between 0.0 and 1.0
        //buttons.layer.anchorPoint = CGPointMake(sz.width/2, sz.height/2)

    
        [self enableButtons];
    }
}

-(void)continueSpinning {
    [UIView animateWithDuration:20 delay:0.0
                        options:(UIViewAnimationOptionAllowUserInteraction |
                                 UIViewAnimationOptionCurveLinear
                                 |  UIViewAnimationOptionRepeat)
                     animations:^(void){
                         if(!rotated){
                             buttons.transform = CGAffineTransformMakeRotation(M_PI);
                             rotated = true;
                         }
                         else{
                             buttons.transform = CGAffineTransformMakeRotation(-2*M_PI);
                             rotated = false;
                         }
                     }
                     completion:nil
                     
     ];

    
    [self performSelector:@selector(continueSpinning) withObject:nil afterDelay:20];
}

-(void)fixFrame{
    _BlueButton.frame = [[_BlueButton.layer presentationLayer] frame];
    
    _RedButton.frame = [[_RedButton.layer presentationLayer] frame];
    
    _YellowButton.frame = [[_YellowButton.layer presentationLayer] frame];
    
    _GreenButton.frame = [[_GreenButton.layer presentationLayer] frame];
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

- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    UITouch *touch = [touches anyObject];
    CGPoint touchPoint = [touch locationInView:self.view];
    NSInteger playerClick;

    CALayer *blue = (CALayer*)[self.BlueButton.layer presentationLayer];
        CALayer *red = (CALayer*)[self.RedButton.layer presentationLayer];
        CALayer *green = (CALayer*)[self.GreenButton.layer presentationLayer];
        CALayer *yellow = (CALayer*)[self.YellowButton.layer presentationLayer];
    
    if(CGRectIntersectsRect(red.frame, CGRectMake(touchPoint.x, touchPoint.y, 1, 1))) {
        // This button was hit whilst moving - do something with it here
 
        playerClick = 1;
        
        [self gameButtonClicked:playerClick];
    }
    if(CGRectIntersectsRect(blue.frame, CGRectMake(touchPoint.x, touchPoint.y, 1, 1))) {
        // This button was hit whilst moving - do something with it here

    
        
        playerClick = 4;
        
                [self gameButtonClicked:playerClick];
    }
    if(CGRectIntersectsRect(yellow.frame, CGRectMake(touchPoint.x, touchPoint.y, 1, 1))) {
    
        // This button was hit whilst moving - do something with it here

            playerClick = 2;
        
                [self gameButtonClicked:playerClick];
    }
    if(CGRectIntersectsRect(green.frame, CGRectMake(touchPoint.x, touchPoint.y, 1, 1))) {        // This button was hit whilst moving - do something with it here

            playerClick = 3;
        
    
        [self gameButtonClicked:playerClick];
        
    }
}

- (IBAction)gameButtonClicked:(int) playerClick {
    //after illumination, player repeats sequence
    
    //know which button the users have clicked
    
    //if click right, playerScore++, playerIndex++
    if([memStruct getButton:playerIndex] == playerClick){
        
        _ScoreLabel.text=[NSString stringWithFormat:@"score: %i",++playerScore];
        
        if(playerIndex == roundIndex-1){
            //next round
            playerIndex = 0;
            _RoundLabel.text=[NSString stringWithFormat:@"round: %i",++roundIndex];
            [self playRound];
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
        _ScoreLabel.text=[NSString stringWithFormat:@"score: %i",playerScore];
        _RoundLabel.text=[NSString stringWithFormat:@"round: %i",roundIndex];
        [self playRound];
    }
}

- (IBAction)goToMain:(id) sender {
    //return to main menu view
    
    ViewController *main = [[ViewController alloc] initWithNibName: nil bundle:nil];
    [self presentViewController:main animated:YES completion:nil];
}

@end
