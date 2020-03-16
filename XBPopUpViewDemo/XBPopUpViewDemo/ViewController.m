//
//  ViewController.m
//  XBPopUpViewDemo
//
//  Created by xbingo on 2018/8/6.
//  Copyright © 2018年 xbingo. All rights reserved.
//

#import "ViewController.h"
#import "XBPopUpService.h"
#import "XBTestPopView.h"
#import "XBPopUpViewController.h"
#import "XBDefaultTransition.h"
#import "XBTestPopUpView.h"
#import "XBTestViewController.h"
#import "XBBaseTransition.h"

#import "XBDevelopTools.h"
#import "Masonry.h"
#import "UIViewController+XBPopUp.h"

@interface ViewController ()<UITableViewDelegate,UITableViewDataSource>

@property (nonatomic ,copy) NSArray *dataSource;
@property (nonatomic ,strong) UITableView *tableView;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self dataSource];
    _tableView = [[UITableView alloc] initWithFrame:CGRectZero style:UITableViewStyleGrouped];
    _tableView.dataSource = self;
    _tableView.delegate = self;
    [_tableView registerClass:UITableViewCell.class forCellReuseIdentifier:NSStringFromClass(UITableViewCell.class)];
    [self.view addSubview:_tableView];
    [_tableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.mas_equalTo(self.view);
    }];
    _tableView.hidden = YES;
}


-(NSArray *)dataSource{
    if (!_dataSource) {
        _dataSource = @[
            @{@"name":@"PopUpVCDemo",
              @"list":@[@"系统present样式",@"默认样式",@"自定义样式",@"测试队列和临时隐藏"]
            },
            @{@"name":@"PopUpViewDemo",
              @"list":@[@"系统present样式",@"默认样式",@"自定义样式",@"测试队列和临时隐藏"]
            },
            @{@"name":@"PopUpDemo"}];
    }
    return _dataSource;
}

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return _dataSource.count;
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    NSDictionary *data = _dataSource[section];
    NSArray *list = data[@"list"];
    return list.count;
}
-(NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section{
    return _dataSource[section][@"name"];
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 50;
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass(UITableViewCell.class)];
    NSDictionary *data = _dataSource[indexPath.section];
    NSArray *list = data[@"list"];
    
    cell.textLabel.text = list[indexPath.row];
    return cell;
}


-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    
    NSString *name = _dataSource[indexPath.section][@"name"];
    if ([name isEqualToString:@"PopUpVCDemo"]) {
        
        NSArray *list = _dataSource[indexPath.section][@"list"];
        NSString *style = list[indexPath.row];
        
        if ([style isEqualToString:@"系统present样式"]) {
            XBTestViewController *test = [XBTestViewController new];
//            test.dependVCId = [NSString stringWithFormat:@"%p",self];
            test.presentTransitioning = nil;
            test.dismissTransitioning = nil;
            [test showInPopUpQueue:^(XBPopUpViewHideType popUpViewHideType) {
                ViewController *vc = [ViewController new];
                [self.navigationController pushViewController:vc animated:YES];
            }];
            
            XBTestViewController *test2 = [XBTestViewController new];
            test2.dependVCId = [NSString stringWithFormat:@"%p",self];
            test2.presentTransitioning = nil;
            test2.dismissTransitioning = nil;
            [test2 showInPopUpQueue:^(XBPopUpViewHideType popUpViewHideType) {



            }];
        }
        
        if ([style isEqualToString:@"默认样式"]) {
            XBTestViewController *test = [XBTestViewController new];
            test.presentTransitioning = [XBBaseTransition presentTransition];
            test.dismissTransitioning = [XBBaseTransition dismissTransition];
            [test showInPopUpQueue:^(XBPopUpViewHideType popUpViewHideType) {
                
            }];
        }
        
        if ([style isEqualToString:@"自定义样式"]) {
            XBTestViewController *test = [XBTestViewController new];
            test.presentTransitioning = [XBTestTransition presentTransition];
            test.dismissTransitioning = [XBTestTransition dismissTransition];
            [test showInPopUpQueue:^(XBPopUpViewHideType popUpViewHideType) {
                
            }];
        }
        
        
        if ([style isEqualToString:@"测试队列和临时隐藏"]) {
            // 断言执行结果
            
            /// 1先展示，然后会展示2，隐藏2之后1再展示出来 ，展示完1之后3展示出来
            
            XBTestViewController *test = [XBTestViewController new];
            test.dependVCId = self.xb_dependId;
            test.des = @"1";
            test.priority = XBPopUpPriorityNormal;
            test.lowerPriorityHidden = YES;
            test.emptyAreaEnabled = YES;
            [test showInPopUpQueue:^(XBPopUpViewHideType popUpViewHideType) {
                ViewController *vc = [ViewController new];
                [self.navigationController pushViewController:vc animated:YES];
            }];
            
            dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.5 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                XBTestViewController *test = [XBTestViewController new];
                test.dependVCId = self.xb_dependId;
                test.des = @"2";
                test.priority = XBPopUpPriorityHigh;
                [test showInPopUpQueue:^(XBPopUpViewHideType popUpViewHideType) {
                    
                }];
            });
            
            dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1.0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                XBTestViewController *test = [XBTestViewController new];
                test.dependVCId = self.xb_dependId;
                test.des = @"3";
                test.priority = XBPopUpPriorityLow;
                [test showInPopUpQueue:^(XBPopUpViewHideType popUpViewHideType) {
                    
                }];
            });
        }
    }else{
        XBTestPopView *view = [[XBTestPopView alloc] initWithSize:CGSizeMake(400, 300)];
        [XBPopUpService.sharedService showDefaultCustomPopUpView:view priority:XBPopUpPriorityNormal lowerPriorityHidden:NO fromType:XBPopUpFromCurrentVC emptyAreaEnabled:YES];
    }
    
    
}


- (IBAction)defaultPresent:(UIButton *)sender {
    
    XBTestViewController *test = [XBTestViewController new];
    test.des = @"xbingo";
    [test showInPopUpQueue:^(XBPopUpViewHideType popUpViewHideType) {
        NSLog(@"xbingooooooooooooooooooo");
    }];
    
//    XBTestPopView *popView = [[XBTestPopView alloc] initWithSize:CGSizeMake(300, 400)];
////    popView.centerOffset = CGPointMake(50, 100);
////    [[XBPopUpService sharedService] showDefaultPresentPopUpView:popView priority:XBPopUpPriorityNormal emptyAreaEnabled:NO];
////    [[XBPopUpService sharedService] showCustomPopUpView:popView priority:XBPopUpPriorityNormal lowerPriorityHidden:YES fromType:XBPopUpFromRoot emptyAreaEnabled:NO presentTransitioning:nil dismissTransitioning:nil];
//    [[XBPopUpService sharedService] showDefaultCustomPopUpView:popView priority:XBPopUpPriorityNormal lowerPriorityHidden:YES fromType:XBPopUpFromRoot emptyAreaEnabled:NO];
}
- (IBAction)defaultCustom:(UIButton *)sender {
    XBTestPopView *popView = [[XBTestPopView alloc] initWithSize:CGSizeMake(200, 300)];
    [[XBPopUpService sharedService] showDefaultCustomPopUpView:popView priority:XBPopUpPriorityNormal emptyAreaEnabled:NO ];
}
- (IBAction)emptyEnabled:(UIButton *)sender {
    XBTestPopView *popView = [[XBTestPopView alloc] initWithSize:CGSizeMake(100, 200)];
    [[XBPopUpService sharedService] showDefaultCustomPopUpView:popView priority:XBPopUpPriorityHigh emptyAreaEnabled:YES];
}
- (IBAction)custonView:(UIButton *)sender {
    
    XBTestPopUpView *popView = [[XBTestPopUpView alloc]initWithFrame:[UIApplication sharedApplication].keyWindow.bounds];
    popView.priority = XBPopUpPriorityVeryHigh;
    [[XBPopUpQueue sharedService] addView:popView];
    
}
- (IBAction)showByQueue:(UIButton *)sender {
    [self defaultPresent:nil];
    [self defaultCustom:nil];
    [self emptyEnabled:nil];
    [self custonView:nil];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
