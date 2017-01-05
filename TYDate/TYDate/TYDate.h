//
//  TYDate.h
//  TYBudeJie
//
//  Created by 马天野 on 2017/1/5.
//  Copyright © 2017年 MTY. All rights reserved.
//  时间判断工具类

#import <Foundation/Foundation.h>

@interface TYDate : NSObject

/**
 创建一个单例对象

 @return 单例对象
 */
+ (instancetype)shareInstance;

/**
 判断是否是今年

 @param serverTime 服务器获取的时间
 @return 是今年
 */
- (BOOL)isThisYear:(NSString *)serverTime;

/**
 判断是否是今天

 @param serverTime 服务器获取的时间
 @return 是今天
 */
- (BOOL)isThisToday:(NSString *)serverTime;

/**
 判断是否是昨天

 @param serverTime 服务器获取的时间
 @return 是昨天
 */
- (BOOL)isThisYesterday:(NSString *)serverTime;

/**
 服务器获取的时间距当前的时间差

 @param serverTime 服务器获取的时间
 @return 时间差
 */
- (NSDateComponents *)deltaWithNow:(NSString *)serverTime;

/**
 服务器时间距当前时间差的直观显示

 @param serverTime 服务器获取的时间
 @return 一种直观的时间显示方式
 */
- (NSString *)timeStr:(NSString *)serverTime;

@end
