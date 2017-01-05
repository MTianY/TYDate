//
//  TYDate.m
//  TYBudeJie
//
//  Created by 马天野 on 2017/1/5.
//  Copyright © 2017年 MTY. All rights reserved.
//

#import "TYDate.h"

@interface TYDate ()

@end

@implementation TYDate

+ (instancetype)shareInstance {
    
    static id instance = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        instance = [[self alloc] init];
    });
    return instance;
}

- (NSDate *)serverCreateDate:(NSString *)serverTime {
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    dateFormatter.dateFormat = @"yyyy-MM-dd HH:mm:ss";
    NSDate *createDate = [dateFormatter dateFromString:serverTime];
    return createDate;
}

- (BOOL)isThisYear:(NSString *)serverTime {
    
    // 获取当前日历
    NSCalendar *calendar = [NSCalendar currentCalendar];
    // 获取调用者的日期年份
    NSDate *createDate = [self serverCreateDate:serverTime];
    NSDateComponents *createCmp = [calendar components:NSCalendarUnitYear fromDate:createDate];
    // 获取当前时间
    NSDate *curDate = [NSDate date];
    // 获取当前时间的日期年份
    NSDateComponents *curCmp = [calendar components:NSCalendarUnitYear fromDate:curDate];
    
    return createCmp.year == curCmp.year;
}

- (BOOL)isThisToday:(NSString *)serverTime {
    NSCalendar *calendar = [NSCalendar currentCalendar];
    NSDate *createDate = [self serverCreateDate:serverTime];
    return [calendar isDateInToday:createDate];
}

- (BOOL)isThisYesterday:(NSString *)serverTime {
    NSCalendar *calendar = [NSCalendar currentCalendar];
    NSDate *createDate = [self serverCreateDate:serverTime];
    return [calendar isDateInYesterday:createDate];
}

- (NSDateComponents *)deltaWithNow:(NSString *)serverTime {
    NSCalendar *calendar = [NSCalendar currentCalendar];
    NSDate *createDate = [self serverCreateDate:serverTime];
    return [calendar components:NSCalendarUnitHour | NSCalendarUnitMinute fromDate:createDate toDate:[NSDate date] options:NSCalendarWrapComponents];
}

- (NSString *)timeStr:(NSString *)serverTime {
    NSString *str = nil;
    NSDate *createDate = [self serverCreateDate:serverTime];
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    NSDateComponents *deltaTime = [self deltaWithNow:serverTime];
    if([self isThisYear:serverTime]) {   // 今年
        if([self isThisToday:serverTime]){   // 今天
            if(deltaTime.hour >= 1) {   // 时间差大于1小时
                str = [NSString stringWithFormat:@"%ld小时前",deltaTime.hour];
            }else if (deltaTime.minute >= 1){   // 时间差大于1分钟
                str = [NSString stringWithFormat:@"%ld分钟前",deltaTime.minute];
            }else {
                // 小于1分钟
                str = @"刚刚";
            }
        }else if([self isThisYesterday:serverTime]){
            dateFormatter.dateFormat = @"昨天 HH:mm";
            str = [dateFormatter stringFromDate:createDate];
        }else {
            // 昨天之前
            dateFormatter.dateFormat = @"MM-dd HH:mm:ss";
            str = [dateFormatter stringFromDate:createDate];
        }
    }else { // 非今年
        str = serverTime;
    }
    return str;    
}

@end
