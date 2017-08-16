//
//  DMForwardObject.m
//  DMMessageForwardDemo
//
//  Created by lbq on 2017/8/16.
//  Copyright © 2017年 lbq. All rights reserved.
//

#import "DMForwardObject.h"
#import <objc/runtime.h>

@implementation DMForwardObject

+ (instancetype) sharedInstance{
    static DMForwardObject *unrecognizedSelectorSolveObject;
    static dispatch_once_t  once_token;
    dispatch_once(&once_token, ^{
        unrecognizedSelectorSolveObject = [[DMForwardObject alloc] init];
    });
    return unrecognizedSelectorSolveObject;
}

- (void)doExcept
{
    NSLog(@"%s",__FUNCTION__);
}

+ (BOOL)resolveInstanceMethod:(SEL)sel
{
    NSLog(@"%s",__FUNCTION__);
    if (![self respondsToSelector:sel]) {
        SEL newSel = @selector(doExcept);
        Method swizzledMethod = class_getInstanceMethod([self class], newSel);
        //让sel 对应 成doExcept的IMP
        BOOL didAddMethod =
        class_addMethod([self class],
                        sel,
                        method_getImplementation(swizzledMethod),
                        method_getTypeEncoding(swizzledMethod));
        return didAddMethod;
    }
    return [super resolveInstanceMethod:sel];
}
@end
