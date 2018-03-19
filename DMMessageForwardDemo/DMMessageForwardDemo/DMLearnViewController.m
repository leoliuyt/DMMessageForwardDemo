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
    [learnObj normalInvokeTest];
//#pragma clang diagnostic push
//#pragma clang diagnostic ignored "-Warc-performSelector-leaks"
////    [learnObj performSelector:@selector(test)];
//    [learnObj performSelector:@selector(doExcept)];
//#pragma clang diagnostic pop
    
//
    if ([learnObj respondsToSelector:@selector(test)]) {//通过消息转发 resolveInstanceMethod 来返回解决时 会返回YES 其他转发方式会返回NO
        NSLog(@"respondsToSelector YES");
    }

    if ([learnObj.class instancesRespondToSelector:@selector(test)]) {
        NSLog(@"instancesRespondToSelector YES");
    }
//
//    if ([DMLearnObject respondsToSelector:@selector(classFunc)]) {
//        NSLog(@"%s",__func__);
//    }
}


@end
