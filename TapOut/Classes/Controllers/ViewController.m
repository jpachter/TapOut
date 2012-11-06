//
//  ViewController.m
//  TapOut
//
//  Created by Justin on 11/4/12.
//  Copyright (c) 2012 CSE483W. All rights reserved.
//

#import "ViewController.h"
#import "ClassicViewController.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(IBAction) goToClassic:(id)sender{
    ClassicViewController *classic = [[ClassicViewController alloc] initWithNibName: nil bundle:nil];
    [self presentViewController:classic animated:YES completion:nil];
}


@end
