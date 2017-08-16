//
//  DMForwardObject.h
//  DMMessageForwardDemo
//
//  Created by lbq on 2017/8/16.
//  Copyright © 2017年 lbq. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface DMForwardObject : NSObject

+ (instancetype) sharedInstance;

- (void)doExcept;

@end
