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

- (instancetype)initWithTarget:(id)target{
    [self setTargets:@[target]];
    return self;
}

+ (instancetype)proxyWithTarget:(id)target{
    return [[self alloc] initWithTarget:target];
}

- (instancetype)init
{
    return self;
}

- (void)setTargets:(NSArray *)targets{
    self.weakRefTargets = [NSPointerArray weakObjectsPointerArray];
    for (id delegate in targets) {
        [self.weakRefTargets addPointer:(__bridge void *)delegate];
    }
}

- (BOOL)respondsToSelector:(SEL)aSelector{
    for (id target in self.weakRefTargets) {
        if ([target respondsToSelector:aSelector]) {
            return YES;
        }
    }
    return NO;
}

- (NSMethodSignature *)methodSignatureForSelector:(SEL)aSelector{
    NSMethodSignature *sig = nil;
    for (id target in self.weakRefTargets) {
        if ((sig = [target methodSignatureForSelector:aSelector])) {
            break;
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
