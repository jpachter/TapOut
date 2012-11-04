//
//  ClassicViewController.m
//  appgame
//
//  Created by CSE483W on 11/2/12.
//  Copyright (c) 2012 CSE483W. All rights reserved.
//

#define kStateRunning 1
#define kStateGameOver 2

#import "ClassicViewController.h"


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
	// Do any additional setup after loading the view.
    [self startgame];
    gameState=kStateRunning;
    [NSTimer scheduledTimerWithTimeInterval:2 target:self selector:@selector(genrtrndnum) userInfo:nil repeats:YES];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void) startgame{
    score=0;
    arrindex=0;
}

-(void)genrtrndnum{
    if(gameState == kStateRunning){
        //
        int r=arc4random()%4+1;
        arry[arrindex]=r;
        arrindex+=1;
        if(r==1){
            _redbutton.alpha=1;
            _clickwhat.text=[NSString stringWithFormat:@"button1"];
             [NSTimer scheduledTimerWithTimeInterval:1 target:self selector:@selector(colorback) userInfo:nil repeats:NO];
        }
        else if (r==2)
        {
            _yellowbutton.alpha=1;
            _clickwhat.text=[NSString stringWithFormat:@"button2"];
            [NSTimer scheduledTimerWithTimeInterval:1 target:self selector:@selector(colorback) userInfo:nil repeats:NO];
        }
        else if (r==3)
        {
            _bluebutton.alpha=1;
            _clickwhat.text=[NSString stringWithFormat:@"button3"];
            [NSTimer scheduledTimerWithTimeInterval:1 target:self selector:@selector(colorback) userInfo:nil repeats:NO];
        }
        else if (r==4)
        {
            _greenbutton.alpha=1;
            _clickwhat.text=[NSString stringWithFormat:@"button4"];
            [NSTimer scheduledTimerWithTimeInterval:1 target:self selector:@selector(colorback) userInfo:nil repeats:NO];
        }
    }
    else if(gameState == kStateGameOver){
        //gameover
        _goback.hidden=0;
        _replay.hidden=0;
        _gameover.hidden=0;
        _gameoverlabel.hidden=0;
        
    }
}

-(void)colorback{
    _redbutton.alpha=0.5;
    _bluebutton.alpha=0.5;
    _greenbutton.alpha=0.5;
    _yellowbutton.alpha=0.5;
}


- (IBAction)button1:(id)sender {
    if(arry[arrindex-1]==1){
        score+=1;
        _scoreLabel.text=[NSString stringWithFormat:@"score: %i",score];
    }
    else{
        gameState=kStateGameOver;
    }
}

- (IBAction)button2:(id)sender {
    if(arry[arrindex-1]==2){
        score+=1;
        _scoreLabel.text=[NSString stringWithFormat:@"score: %i",score];
    }
    else{
        gameState=kStateGameOver;
    }
}

- (IBAction)button3:(id)sender {
    if(arry[arrindex-1]==3){
        score+=1;
        _scoreLabel.text=[NSString stringWithFormat:@"score: %i",score];
    }
    else{
        gameState=kStateGameOver;
    }
}

- (IBAction)button4:(id)sender {
    if(arry[arrindex-1]==4){
        score+=1;
        _scoreLabel.text=[NSString stringWithFormat:@"score: %i",score];
    }
    else{
    gameState=kStateGameOver;
    }
}
@end
