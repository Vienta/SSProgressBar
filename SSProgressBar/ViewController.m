//
//  ViewController.m
//  SSProgressBar
//
//  Created by 束 永兴 on 13-9-12.
//  Copyright (c) 2013年 Candy. All rights reserved.
//

#import "ViewController.h"
#import "SSProgressBar.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
    SSProgressBar *pgs = [[SSProgressBar alloc] initWithFrame:CGRectMake(0, 0, 200, 80)];
    [self.view addSubview:pgs];
    pgs.cornerRadius = 8.0;
    pgs.innerRadius = 7.0;
    pgs.trackTintColor = [UIColor grayColor];
    pgs.backgroundColor = [UIColor clearColor];
    pgs.progress = 1.0;
    pgs.center = self.view.center;
    pgs.progressImage = [UIImage imageNamed:@"JTYColumnGreenBody.png"];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
