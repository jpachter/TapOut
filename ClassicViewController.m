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
#import "Memory.h"
#import <time.h>

@implementation ClassicViewController

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
    
    //Create memory structure.
    //memory = [[Memory alloc] init];
    
    // Do any additional setup after loading the view.
    
    //Game is running. (User previously clicked home button to exit). Resume game.
    if(gameState == GAME_RUNNING){
        //Wait 2 seconds, call playGame.
        [NSTimer scheduledTimerWithTimeInterval:2 target:self selector:@selector(playgame) userInfo:nil repeats:NO];
    }
    //Game startup. Initialize and begin.
    else{
        [self startgame];
        gameState=GAME_RUNNING;
        
        [NSTimer scheduledTimerWithTimeInterval:2 target:self selector:@selector(playgame) userInfo:nil repeats: NO];
    }
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void) startgame{
    score=0;
    arrindex=0;
    playerindex=0;
    roundindex=1;
    [self build];
}

-(void) build{
    for(int i=0;i<30;i++)
    {
        arry[i]=arc4random()%4+1;
    }
}

-(void)playgame{

        //if(gameState == GAME_RUNNING){
            
            //disable the click funciton of all the colored buttons when illuminate colors.
            //Button11.enabled=NO;
            //Button22.enabled=NO;
            //Button33.enabled=NO;
            //Button44.enabled=NO;
            
            //illuminate button --- read value in arr from 0 to round-1
            arrindex=0;
            _ArrindexLabel.text=[NSString stringWithFormat:@"round: %i",arrindex];
            //control the illumination per round
            myTimer=[NSTimer scheduledTimerWithTimeInterval:2 target:self selector:@selector(illumination:) userInfo:nil repeats:YES];
            _ArrindexLabel.text=[NSString stringWithFormat:@"round: %i",arrindex];
            
            playerindex=0;
            //Button11.enabled=YES;
            //Button22.enabled=YES;
            //Button33.enabled=YES;
            //Button44.enabled=YES;
            
        //}
        //else if(gameState == GAME_OVER){
            //gameover
            //_GoBack.hidden=0;
            // _Replay.hidden=0;
           // _GameOver.hidden=0;
            //_GameoverLabel.hidden=0;
            //////
        //  }
    
}

-(void) illumination:(NSTimer *) timer{   //illuminate buttons whose values are read from arry
    int index=arry[arrindex];
    _ArrindexLabel.text=[NSString stringWithFormat:@"arrindex: %i",arrindex];
    if(index==1){
        _RedButton.alpha=1;
        _ClickWhat.text=[NSString stringWithFormat:@"button1"];
        [self performSelector:@selector(colorback) withObject:nil afterDelay:1.0];
    }
    else if (index==2)
    {
        _YellowButton.alpha=1;
        _ClickWhat.text=[NSString stringWithFormat:@"button2"];
        [self performSelector:@selector(colorback) withObject:nil afterDelay:1.0];
    }
    else if (index==3)
    {
        _GreenButton.alpha=1;
        _ClickWhat.text=[NSString stringWithFormat:@"button3"];
        [self performSelector:@selector(colorback) withObject:nil afterDelay:1.0];
    }
    else if (index==4)
    {
        _BlueButton.alpha=1;
        _ClickWhat.text=[NSString stringWithFormat:@"button4"];
        [self performSelector:@selector(colorback) withObject:nil afterDelay:1.0];
    }
    arrindex+=1;
    if(arrindex==roundindex)  //stop the calling of illumination.
    {
        [myTimer invalidate];
    }
}

-(void)colorback{
    _RedButton.alpha=0.2;
    _BlueButton.alpha=0.2;
    _GreenButton.alpha=0.2;
    _YellowButton.alpha=0.2;
}


//player click buttons. I assume that whenever the player has a right click, the score will increase by one.
- (IBAction)gameButtonClicked:(id)sender {
    
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
    
    if(arry[playerindex] == tmp){
    
        _ScoreLabel.text=[NSString stringWithFormat:@"score: %i",++score];
        
        if(playerindex == roundindex-1){
            playerindex = 0;
            _RoundLabel.text=[NSString stringWithFormat:@"round: %i",++roundindex];
            [self playgame];
        }
        else{
            playerindex++;
        }
    }
    else{
        gameState = GAME_OVER;
        [self alertOKCancelAction];
        
    }
}


/*-(IBAction)GobackButton:(id)sender{
 ViewController *main=[[ViewController alloc] initWithNibName: nil bundle:nil];
 [self presentViewController:main animated:YES completion:nil];
 }
 
 -(IBAction)ReplayButton:(id)sender{
 ClassicViewController *classic = [[ClassicViewController alloc] initWithNibName: nil bundle:nil];
 [self presentViewController:classic animated:YES completion:nil];
 
 }*/

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
