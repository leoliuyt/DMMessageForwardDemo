//
//  LLForwardProxyCenter.h
//  DMMessageForwardDemo
//
//  Created by lbq on 2017/8/16.
//  Copyright © 2017年 lbq. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface LLForwardProxyCenter : NSProxy

@property (nonatomic, copy) NSArray* targets;

- (instancetype)init;
- (instancetype)initWithTarget:(id)target;
+ (instancetype)proxyWithTarget:(id)target;

@end
