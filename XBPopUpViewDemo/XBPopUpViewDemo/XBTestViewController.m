//
//  XBTestViewController.m
//  XBPopUpViewDemo
//
//  Created by xbingo on 2019/11/4.
//  Copyright © 2019 xbingo. All rights reserved.
//

#import "XBTestViewController.h"
#import "XBBaseTransition.h"

@interface XBTestViewController ()

@end

@implementation XBTestViewController

- (instancetype)init
{
    self = [super init];
    if (self) {
        self.lowerPriorityHidden = YES;
        self.emptyAreaEnabled = NO;
        self.priority = XBPopUpPriorityNormal;
        self.presentTransitioning = [XBTestTransition presentTransition];
        self.dismissTransitioning = [XBTestTransition dismissTransition];
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.popUpContentView.frame = CGRectMake(100, 200, 200, 200);
    self.popUpContentView.backgroundColor = [UIColor yellowColor];
    
    _testBtn = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, 100, 100)];
    [_testBtn setTitle:_des forState:UIControlStateNormal];
    _testBtn.backgroundColor = [UIColor redColor];
    [_testBtn addTarget:self action:@selector(test:) forControlEvents:UIControlEventTouchUpInside];
    [self.popUpContentView addSubview:_testBtn];
}

-(void)setDes:(NSString *)des{
    _des = des;
}

-(void)test:(UIButton *)sender{
    if (self.willHideBlock) {
        self.willHideBlock(XBPopUpViewHideTypeAfterSelected);
    }
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
