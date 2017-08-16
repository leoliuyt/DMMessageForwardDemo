//
//  DMLearnViewController.m
//  DMMessageForwardDemo
//
//  Created by lbq on 2017/8/16.
//  Copyright © 2017年 lbq. All rights reserved.
//

#import "DMLearnViewController.h"
#import "DMLearnObject.h"

@interface DMLearnViewController ()

@end

@implementation DMLearnViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)invokeAction:(id)sender {
    DMLearnObject *learnObj = [DMLearnObject new];
#pragma clang diagnostic push
#pragma clang diagnostic ignored "-Warc-performSelector-leaks"
    [learnObj performSelector:@selector(test)];
#pragma clang diagnostic pop
    
}


@end
