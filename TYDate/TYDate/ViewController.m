//
//  ViewController.m
//  TYDate
//
//  Created by 马天野 on 2017/1/5.
//  Copyright © 2017年 MTY. All rights reserved.
//

#import "ViewController.h"
#import "TYDate.h"

@interface ViewController ()

@property (weak, nonatomic) IBOutlet UILabel *timeLabel;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // 测试时间
    NSString *serverTime = @"2017-1-5 19:59:55";
    _timeLabel.text = [[TYDate shareInstance] timeStr:serverTime];
    
}

@end
