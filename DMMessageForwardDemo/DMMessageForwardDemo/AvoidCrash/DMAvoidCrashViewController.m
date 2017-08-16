//
//  DMAvoidCrashViewController.m
//  DMMessageForwardDemo
//
//  Created by lbq on 2017/8/16.
//  Copyright © 2017年 lbq. All rights reserved.
//

#import "DMAvoidCrashViewController.h"
#import "NSObject+LLAvoidCrash.h"

@interface DMAvoidCrashViewController ()

@end

@implementation DMAvoidCrashViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [NSObject launchAvoidCrach];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


- (IBAction)invokeUnrecognize:(id)sender {
    NSObject *avoidObj = [NSObject new];
#pragma clang diagnostic push
#pragma clang diagnostic ignored "-Warc-performSelector-leaks"
    [avoidObj performSelector:@selector(test)];
#pragma clang diagnostic pop
}

@end
