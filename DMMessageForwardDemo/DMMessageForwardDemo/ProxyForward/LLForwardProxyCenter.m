//
//  LLForwardProxyCenter.m
//  DMMessageForwardDemo
//
//  Created by lbq on 2017/8/16.
//  Copyright © 2017年 lbq. All rights reserved.
//

#import "LLForwardProxyCenter.h"

@interface LLForwardProxyCenter()

@property (nonatomic, strong) NSPointerArray *weakRefTargets;

@end

@implementation LLForwardProxyCenter

- (void)setForwardDelegates:(NSArray *)forwardDelegates{
    self.weakRefTargets = [NSPointerArray weakObjectsPointerArray];
    for (id delegate in forwardDelegates) {
        [self.weakRefTargets addPointer:(__bridge void *)delegate];
    }
}

- (BOOL)respondsToSelector:(SEL)aSelector{
    if ([super respondsToSelector:aSelector]) {
        return YES;
    }
    for (id target in self.weakRefTargets) {
        if ([target respondsToSelector:aSelector]) {
            return YES;
        }
    }
    return NO;
}

- (NSMethodSignature *)methodSignatureForSelector:(SEL)aSelector{
    NSMethodSignature *sig = [super methodSignatureForSelector:aSelector];
    if (!sig) {
        for (id target in self.weakRefTargets) {
            if ((sig = [target methodSignatureForSelector:aSelector])) {
                break;
            }
        }
    }
    
    return sig;
}

//转发方法调用给所有delegate
- (void)forwardInvocation:(NSInvocation *)anInvocation{
    for (id target in self.weakRefTargets) {
        if ([target respondsToSelector:anInvocation.selector]) {
            [anInvocation invokeWithTarget:target];
        }
    }
}


@end
