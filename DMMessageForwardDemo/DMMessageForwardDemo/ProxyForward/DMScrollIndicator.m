//
//  DMScrollIndicator.m
//  DMMessageForwardDemo
//
//  Created by lbq on 2017/8/16.
//  Copyright © 2017年 lbq. All rights reserved.
//

#import "DMScrollIndicator.h"

#define kScreenW  [UIScreen mainScreen].bounds.size.width
#define kScreenH  [UIScreen mainScreen].bounds.size.height

#define kIndicatorH 20.


@interface DMScrollIndicator()<UIScrollViewDelegate>

@property (nonatomic, strong) UILabel *label;

@end

@implementation DMScrollIndicator

- (instancetype) initWithFrame:(CGRect)frame
{
    if ([super initWithFrame:frame])
    {
        self.backgroundColor = [UIColor orangeColor];
        [self addSubview:self.label];
    }
    return self;
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    self.center = CGPointMake(kScreenW - 20, kIndicatorH/2.+ 64. + (kScreenH-64.-kIndicatorH)*(scrollView.contentOffset.y + 64. )/(scrollView.contentSize.height-(kScreenH-64.)));
    self.label.text = [NSString stringWithFormat:@"%tu",self.currentIndex];
}

- (UILabel *)label
{
    if(!_label){
        _label = [[UILabel alloc] init];
        _label.frame = CGRectMake(0, 0, self.frame.size.width, self.frame.size.height);
        _label.textAlignment = NSTextAlignmentCenter;
    }
    return _label;
}

@end
