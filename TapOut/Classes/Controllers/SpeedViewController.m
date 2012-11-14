//
//  SpeedViewController.m
//  TapOut
//
//  Created by CSE483W on 11/11/12.
//  Copyright (c) 2012 CSE483W. All rights reserved.
//
#define GAME_RUNNING 1
#define GAME_OVER 2

#import "SpeedViewController.h"
#import "ViewController.h"
#import "Memory.h"
#import <time.h>
//#import <NSThread.h>
#import <QuartzCore/QuartzCore.h>

@interface SpeedViewController ()

@end

@implementation SpeedViewController

@synthesize gameState;

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
    [self startgame];
    [self playgame];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void) startgame{
    //initialize everything
    
    score=0;
    arrindex=0;
    playerindex=0;
    roundindex=0;
    _ClickWhat.text=@"Begin Game!";
    [self build];
}

-(void) build{
    //build the array. how to use build of memory.m?
    
    for(int i=0;i<40;i++)
    {
        arry[i]=arc4random()%4+1;
    }
}

-(void)playgame{
    if(playerindex!=roundindex){
        [self alertOKCancelAction];
    }
    else{
        //disable all colored buttons when illuminate
        //[self disablebuttons];
        roundindex++;
        playerindex=0;
        _PlayerIndex.text=[NSString stringWithFormat:@"pindex: %i",playerindex];
        _RoundLabel.text=[NSString stringWithFormat:@"round: %i",roundindex];
        
        //illuminate button --- read value in arr from 0 to round-1
        arrindex=0;
        
        //control the illumination per round
        myTimer=[NSTimer scheduledTimerWithTimeInterval:1 target:self selector:@selector(illumination:) userInfo:nil repeats:YES];
        [NSTimer scheduledTimerWithTimeInterval:2.6*roundindex target:self selector:@selector(playgame) userInfo:nil repeats:NO];
    }
}

-(void) disablebuttons{
    //disable all buttons when illuminate
    
    _RedButton.enabled=NO;
    _YellowButton.enabled=NO;
    _GreenButton.enabled=NO;
    _BlueButton.enabled=NO;
}

-(void) enablebuttons{
    //enable buttons after illumination
    
    _RedButton.enabled=YES;
    _YellowButton.enabled=YES;
    _GreenButton.enabled=YES;
    _BlueButton.enabled=YES;
}

-(void) illumination:(NSTimer *) timer{
    //illuminate buttons whose values are read from arry
    
    UIButton *button;
    int index=arry[arrindex];
    _ClickWhat.text=[NSString stringWithFormat:@"Click %i",index];
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
    
    arrindex+=1;
    if(arrindex==roundindex)  //stop the calling of illumination.
    {
        [myTimer invalidate];
        [self enablebuttons];
        timercount=roundindex;
        Timer2=[NSTimer scheduledTimerWithTimeInterval:0.7 target:self selector:@selector(TimerCount:) userInfo:nil repeats:YES];
    }
}

-(void) TimerCount:(NSTimer *) timer{
    _ReminingTime.text=[NSString stringWithFormat:@"Remining Time: %i",timercount];
    timercount--;
    if(timercount<0){
        [Timer2 invalidate];
    }
    
}

-(void) buttonFade: (UIButton*) button{
    
    button.selected = TRUE;
    CATransition *transition = [CATransition animation];
    transition.duration = .3;
    transition.type = kCATransitionFade;
    transition.delegate = self;
    [button.layer addAnimation:transition forKey:nil];
    button.selected = TRUE;
}


-(void) buttonReturn: (UIButton*) button{
    
    button.selected = FALSE;
    CATransition *transition = [CATransition animation];
    transition.duration = .3;
    transition.type = kCATransitionFade;
    transition.delegate = self;
    [button.layer addAnimation:transition forKey:nil];
    button.selected = FALSE;
}


//player click buttons. I assume that whenever the player has a right click, the score will increase by one.
- (IBAction)gameButtonClicked:(id)sender {
    // after illumination, player click buttons
    
    //know which button the users have clicked.
    NSInteger tmp;
    switch ( ((UIButton*)sender).tag ){
            
        case 1:
            tmp = 1;
            break;
        case 2:
            tmp = 2;
            break;
        case 3:
            tmp = 3;
            break;
        case 4:
            tmp = 4;
            break;
            
    }
    
    //if click right, score++, playerindex++
    if(arry[playerindex] == tmp){
        
        _ScoreLabel.text=[NSString stringWithFormat:@"score: %i",++score];
        playerindex++;
        _PlayerIndex.text=[NSString stringWithFormat:@"pindex: %i",playerindex];
        if(playerindex > roundindex){
            [self alertOKCancelAction];
        }
    }
    else{
        //if click wrong, game over.
        gameState = GAME_OVER;
        [self alertOKCancelAction];
        
    }
}

- (void)alertOKCancelAction {
    // open a alert with an OK and cancel button
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Game Over" message:@"Try again?" delegate:self cancelButtonTitle:@"Main Menu" otherButtonTitles:@"OK", nil];
    [alert show];
}

- (void)alertView:(UIAlertView *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex {
    // the user clicked one of the OK/Cancel buttons
    if (buttonIndex == 0)
    {
        [self goToMain:nil];
    }
    else
    {
        //Rest
        [self startgame];
        _ScoreLabel.text=[NSString stringWithFormat:@"score: %i",score];
        _RoundLabel.text=[NSString stringWithFormat:@"round: %i",roundindex];
        [self playgame];
    }
}

-(IBAction) goToMain:(id)sender{
    ViewController *main = [[ViewController alloc] initWithNibName: nil bundle:nil];
    [self presentViewController:main animated:YES completion:nil];
}


@end
