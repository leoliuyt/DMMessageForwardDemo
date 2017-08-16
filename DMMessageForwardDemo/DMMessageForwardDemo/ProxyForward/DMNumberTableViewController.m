//
//  DMNumberTableViewController.m
//  DMMessageForwardDemo
//
//  Created by lbq on 2017/8/16.
//  Copyright © 2017年 lbq. All rights reserved.
//

#import "DMNumberTableViewController.h"
#import "LLForwardProxyCenter.h"
#import "DMScrollIndicator.h"


#define kScreenW  [UIScreen mainScreen].bounds.size.width
#define kScreenH  [UIScreen mainScreen].bounds.size.height

@interface DMNumberTableViewController ()<UITableViewDelegate,UITableViewDataSource>
@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (nonatomic, strong) NSArray *heights;

@property (nonatomic, strong) LLForwardProxyCenter *forwardProxyCenter;
@property (nonatomic, strong) DMScrollIndicator *scrollIndicator;
@end

@implementation DMNumberTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.automaticallyAdjustsScrollViewInsets = YES;
    self.scrollIndicator = [[DMScrollIndicator alloc] initWithFrame:CGRectMake(kScreenW - 40, 64, 40, 20)];
    self.forwardProxyCenter = [[LLForwardProxyCenter alloc] init];
    self.forwardProxyCenter.targets = @[self,self.scrollIndicator];
    self.tableView.delegate = (id)self.forwardProxyCenter;
    self.tableView.dataSource = self;
    self.heights = @[
                     @40,@45,@60,@40,@50,@60,@70,@80,@90,@100,
                     @40,@45,@60,@40,@50,@60,@70,@80,@90,@100,
                     @40,@45,@60,@40,@50,@60,@70,@80,@90,@100,
                     @40,@45,@60,@40,@50,@60,@70,@80,@90,@100,
                     @40,@45,@60,@40,@50,@60,@70,@80,@90,@100,
                     @40,@45,@60,@40,@50,@60,@70,@80,@90,@100,
                     @40,@45,@60,@40,@50,@60,@70,@80,@90,@100,
                     @40,@45,@60,@40,@50,@60,@70,@80,@90,@100,
                     @40,@45,@60,@40,@50,@60,@70,@80,@90,@100,
                     @40,@45,@60,@40,@50,@60,@70,@80,@90,@100,
                     ];
    self.tableView.indicatorStyle = UIScrollViewIndicatorStyleBlack;
    [self.tableView addObserver:self forKeyPath:@"contentOffset" options:NSKeyValueObservingOptionNew context:nil];
    [self.view addSubview:self.scrollIndicator];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary<NSString *,id> *)change context:(void *)context
{
    NSValue *point = [change objectForKey:@"new"];
    CGPoint p = [point CGPointValue];
    p = CGPointMake(p.x, p.y+CGRectGetMidY(self.scrollIndicator.frame));
    
    NSIndexPath *index = [self.tableView indexPathForRowAtPoint:p];
    
    self.scrollIndicator.currentIndex = index.row;
}

//MARK: UITableViewDelegate UITableViewDataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.heights.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"Cell"];
    cell.textLabel.text = [NSString stringWithFormat:@"%tu",indexPath.row];
    return cell;
}

- (CGFloat) tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSNumber *number = self.heights[indexPath.row];
    return [number floatValue];
}

- (void)dealloc
{
    NSLog(@"%s",__func__);
    [self.tableView removeObserver:self forKeyPath:@"contentOffset"];
}

@end
