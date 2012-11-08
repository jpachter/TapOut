//
//  ClassicViewController.m
//  TapOut
//
//  Created by CSE483W on 11/7/12.
//  Copyright (c) 2012 CSE483W. All rights reserved.
//
#define kStateRunning 1
#define kStateGameOver 2

#import "ClassicViewController.h"
#import "ViewController.h"
#import "Memory.h"
#import <time.h>


@interface ClassicViewController ()

@end

@implementation ClassicViewController

@synthesize gameState,Button11,Button22,Button33,Button44;

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
	// Do any additional setup after loading the view.
    
    if(gameState==kStateRunning){
        [NSTimer scheduledTimerWithTimeInterval:2 target:self selector:@selector(playgame) userInfo:nil repeats:NO];
    }
    else{
        [self startgame];
        gameState=kStateRunning;
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
    roundindex=0;
    [self build];
}

-(void) build{
    for(int i=0;i<30;i++)
    {
        arry[i]=arc4random()%4+1;
    }
}

-(void)playgame{
    if(playerindex!=roundindex){   //player did not click round(number) buttons in last round.
        gameState=kStateGameOver;
        _GameOver.hidden=0;
        _ClickWhat.text=[NSString stringWithFormat:@"round: %i",roundindex];
    }
    else{
        if(gameState == kStateRunning){
            roundindex+=1;
            _RoundLabel.text=[NSString stringWithFormat:@"round: %i",roundindex];
            
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
            
            // in real work, the interval time should be 4*(roundindex+1);
            [NSTimer scheduledTimerWithTimeInterval:2*(roundindex+1) target:self selector:@selector(playgame) userInfo:nil repeats:NO];
        }
        else if(gameState == kStateGameOver){
            //gameover
            //_GoBack.hidden=0;
            // _Replay.hidden=0;
            _GameOver.hidden=0;
            //_GameoverLabel.hidden=0;
            //////
        }
    }
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
        _BlueButton.alpha=1;
        _ClickWhat.text=[NSString stringWithFormat:@"button3"];
        [self performSelector:@selector(colorback) withObject:nil afterDelay:1.0];
    }
    else if (index==4)
    {
        _GreenButton.alpha=1;
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
- (IBAction)Button1:(id)sender {
    if(playerindex>roundindex){   //if the player click more then required button, game over.
        gameState=kStateGameOver;
        _ClickWhat.text=@"game over";
    }
    else{
        if(arry[playerindex]==1){
            score+=1;
            _ScoreLabel.text=[NSString stringWithFormat:@"score: %i",score];
            Button11=(UIButton *)sender;
            playerindex+=1;
        }
        else{
            gameState=kStateGameOver;
        }
    }
}

- (IBAction)Button2:(id)sender {
    if(playerindex>roundindex){   //if the player click more then required button, game over.
        gameState=kStateGameOver;
        _ClickWhat.text=@"game over";
    }
    else{
        if(arry[playerindex]==2){
            score+=1;
            _ScoreLabel.text=[NSString stringWithFormat:@"score: %i",score];
            Button22=(UIButton *)sender;
            playerindex+=1;
        }
        else{
            gameState=kStateGameOver;
        }
    }
}

- (IBAction)Button3:(id)sender {
    if(playerindex>roundindex){   //if the player click more then required button, game over.
        gameState=kStateGameOver;
        _ClickWhat.text=@"game over";
    }
    else{
        if(arry[playerindex]==3){
            score+=1;
            _ScoreLabel.text=[NSString stringWithFormat:@"score: %i",score];
            Button33=(UIButton *)sender;
            playerindex+=1;
        }
        else{
            gameState=kStateGameOver;
        }
    }
}

- (IBAction)Button4:(id)sender {
    if(playerindex>roundindex){   //if the player click more then required button, game over.
        gameState=kStateGameOver;
        _ClickWhat.text=@"game over";
    }
    else{
        if(arry[playerindex]==4){
            score+=1;
            _ScoreLabel.text=[NSString stringWithFormat:@"score: %i",score];
            Button44=(UIButton *)sender;
            playerindex+=1;
        }
        else{
            gameState=kStateGameOver;
        }
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
@end
