//
//  ViewController.m
//  SQAirbnbLogin
//
//  Created by 小六 on 09/02/2017.
//  Copyright © 2017 小六. All rights reserved.
//

#import "ViewController.h"
#import "SQLoginBoard.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)enterLogin:(id)sender {
    SQLoginBoard *board = [[SQLoginBoard alloc] init];
    [self presentViewController:board animated:YES completion:nil];
}

@end
