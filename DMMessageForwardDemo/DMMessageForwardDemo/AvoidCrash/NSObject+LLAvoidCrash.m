//
//  NSObject+LLAvoidCrash.m
//  DMMessageForwardDemo
//
//  Created by lbq on 2017/8/16.
//  Copyright © 2017年 lbq. All rights reserved.
//

#import "NSObject+LLAvoidCrash.h"
#import <UIKit/UIKit.h>
#import <objc/runtime.h>
#import "DMForwardObject.h"

@implementation NSObject (LLAvoidCrash)

+ (void)launchAvoidCrach
{
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        [NSObject exchangeInstanceMethod:[self class]  originalSel:@selector(methodSignatureForSelector:) swizzledSel:@selector(newMethodSignatureForSelector:)];
        [NSObject exchangeInstanceMethod:[self class]  originalSel:@selector(forwardInvocation:) swizzledSel:@selector(newForwardInvocation:)];
    });
}

+ (void)exchangeInstanceMethod:(Class)anClass originalSel:(SEL)method1Sel swizzledSel:(SEL)method2Sel {
    
    
    Method originalMethod = class_getInstanceMethod(anClass, method1Sel);
    Method swizzledMethod = class_getInstanceMethod(anClass, method2Sel);
    
    BOOL didAddMethod =
    class_addMethod(anClass,
                    method1Sel,
                    method_getImplementation(swizzledMethod),
                    method_getTypeEncoding(swizzledMethod));
    
    if (didAddMethod) {
        class_replaceMethod(anClass,
                            method2Sel,
                            method_getImplementation(originalMethod),
                            method_getTypeEncoding(originalMethod));
    }
    
    else {
        method_exchangeImplementations(originalMethod, swizzledMethod);
    }
    
}

#pragma mark forwardTarget
- (NSMethodSignature *)newMethodSignatureForSelector:(SEL)sel{
    
    NSMethodSignature *signature = [self newMethodSignatureForSelector:sel];
    if (signature != nil) {
        return signature;
    }
    //可以在此加入日志信息，栈信息的获取等，方便后面分析和改进原来的代码。
    NSString *crashInfo = [self parseCrash];
    UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@"crash info" message:crashInfo delegate:nil cancelButtonTitle:@"取消" otherButtonTitles:nil];
    [alert show];
    
    DMForwardObject *forwardObj = [DMForwardObject sharedInstance];
    return [forwardObj newMethodSignatureForSelector:sel];
}


- (void)newForwardInvocation:(NSInvocation *)anInvocation{
    
    if([self newMethodSignatureForSelector:anInvocation.selector]){
        [self newForwardInvocation:anInvocation];
        return;
    }
    DMForwardObject *forwardObj = [DMForwardObject sharedInstance];
    if([self methodSignatureForSelector:anInvocation.selector]){
        [anInvocation invokeWithTarget:forwardObj];
    }
}

- (NSString *)parseCrash
{
    NSArray *callStackSymbolsArr = [NSThread callStackSymbols];
    return [callStackSymbolsArr componentsJoinedByString:@"\n"];
}
@end
