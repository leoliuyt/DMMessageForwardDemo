//
//  DMLearnObject.m
//  DMMessageForwardDemo
//  这里主要介绍了一下消息转发的这几个方法的作用
//  Created by lbq on 2017/8/16.
//  Copyright © 2017年 lbq. All rights reserved.
//

#import "DMLearnObject.h"
#import "DMForwardObject.h"
#import <objc/runtime.h>

@interface DMLearnObject()

@property (nonatomic, strong) DMForwardObject *forwardToObject;

@end

@implementation DMLearnObject

- (instancetype)init
{
    self = [super init];
    self.forwardToObject = [DMForwardObject new];
    return self;
}

- (void)normalInvokeTest
{
    NSLog(@"存在的方法：%s",__FUNCTION__);
}

- (void)resolveMethod
{
   NSLog(@"如果没有找到方法 就动态添加该方法：%s",__FUNCTION__);
}

// Dynamically provides an implementation for a given selector for an instance method.
// 在这里可以动态添加 不存在的方法  防止崩溃 如果这步不实现 可以在下一步处理， 这步处理了下面方法就不会再走
+ (BOOL)resolveInstanceMethod:(SEL)sel
{
    NSLog(@"%s",__FUNCTION__);
    //不处理 就需要下一步处理
    if (![self respondsToSelector:sel]) {
        SEL resolveSel = @selector(resolveMethod);
        Method swizzledMethod = class_getInstanceMethod([self class], resolveSel);
        BOOL didAddMethod =
        class_addMethod([self class],
                        sel,
                        method_getImplementation(swizzledMethod),
                        method_getTypeEncoding(swizzledMethod));
        return didAddMethod;
    }
    return [super resolveInstanceMethod:sel];
}

//有机会转发给别的对象 步处理了下面方法就不会再走
- (id)forwardingTargetForSelector:(SEL)aSelector
{
    NSLog(@"%s",__FUNCTION__);
    //将方法转发给别的对象调用
    DMForwardObject *forwardObj = [DMForwardObject new];
    if ([forwardObj respondsToSelector:@selector(doExcept)]) {
        return forwardObj;
    }
    return [super forwardingTargetForSelector:aSelector];
}

// 返回方法签名 如果签名 返回 nil 就不会调用 forwardInvocation：方法
- (NSMethodSignature *)methodSignatureForSelector:(SEL)aSelector
{
    NSLog(@"%s",__FUNCTION__);
    NSMethodSignature *signature = [super methodSignatureForSelector:aSelector];
    if (!signature) {
        signature = [self.forwardToObject methodSignatureForSelector:aSelector];
    }
    return signature;
}

- (void)forwardInvocation:(NSInvocation *)anInvocation
{
    NSLog(@"%s",__FUNCTION__);
    if ([self methodSignatureForSelector:anInvocation.selector]) {
        [anInvocation invokeWithTarget:self.forwardToObject];
    }
}

//如果以上方法都没有处理 那交给下面方法 抛出异常
- (void)doesNotRecognizeSelector:(SEL)aSelector
{
    NSLog(@"%s",__FUNCTION__);
}
@end
