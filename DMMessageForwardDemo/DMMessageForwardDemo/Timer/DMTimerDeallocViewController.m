//
//  DMTimerDeallocViewController.m
//  DMMessageForwardDemo
//
//  Created by leoliu on 2017/8/16.
//  Copyright © 2017年 lbq. All rights reserved.
//

#import "DMTimerDeallocViewController.h"
#import "LLForwardProxyCenter.h"
static NSInteger count = 1;
@interface DMTimerDeallocViewController ()
@property (weak, nonatomic) IBOutlet UILabel *timerLabel;

@property (nonatomic, strong) NSTimer *timer;

@end

@implementation DMTimerDeallocViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    count = 0;
    self.timer = [NSTimer scheduledTimerWithTimeInterval:1
                                                  target:[LLForwardProxyCenter proxyWithTarget:self]
                                                selector:@selector(timerInvoked:)
                                                userInfo:nil
                                                 repeats:YES];
    [self.timer fire];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)timerInvoked:(id)sender
{
    count++;
    self.timerLabel.text = [NSString stringWithFormat:@"%tu",count];
}

- (void)dealloc
{
    if (self.timer) {
        [self.timer invalidate];
        self.timer = nil;
    }
    NSLog(@"%s",__func__);
}

@end
