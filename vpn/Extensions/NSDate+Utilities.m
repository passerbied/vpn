//
//  NSDate+Utilities.m
//
//  Created by wang guoyu on 11-8-1.
//  Copyright 2011 wang guoyu All rights reserved.
//

#import "NSDate+Utilities.h"

#define DATE_COMPONENTS (NSCalendarUnitYear| NSCalendarUnitMonth | NSCalendarUnitDay | NSCalendarUnitWeekday |  NSCalendarUnitHour | NSCalendarUnitMinute | NSCalendarUnitSecond | NSCalendarUnitWeekday | NSCalendarUnitWeekdayOrdinal)
#define CURRENT_CALENDAR [NSCalendar currentCalendar]

@implementation NSDate (Utilities)

#pragma mark Relative Dates
+ (NSString *) convertDateToStringWithFormat:(NSString *) format date:(NSDate *) date
{
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setDateFormat:format];
    return [formatter stringFromDate:date];
}

- (NSString*)displayWithFormat:(NSString*)format
{
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setDateFormat:format];
    return [formatter stringFromDate:self];
}

+ (NSString *) convertDateToWeiboStyleString:(NSDate *) date;
{
    NSDate *now = [NSDate date];
    if ([date isToday])
    {
        NSInteger hoursBeforeNow = [date hoursBeforeDate:now];
        if (hoursBeforeNow < 1) // Less than one hour.
        {
            NSInteger minutesBeforeNow = [date minutesBeforeDate:now];
            return [NSString stringWithFormat:LocalStr(@"format_minutes_before"), minutesBeforeNow];
        }
        else
        {
            return [NSString stringWithFormat:LocalStr(@"format_hours_before"), hoursBeforeNow];
        }
        
        return [NSString stringWithFormat:LocalStr(@"format_today"), [NSDate convertDateToStringWithFormat:@"HH:mm" date:date]];
    }
    if ([date isThisYear]) {
        return [NSDate convertDateToStringWithFormat:@"yyyy-MM-dd HH:mm" date:date];
    } else {
        return [NSDate convertDateToStringWithFormat:@"yyyy-MM-dd HH:mm" date:date];
    }
}

+ (NSDate *) dateWithDaysFromNow: (NSUInteger) days
{
    NSTimeInterval aTimeInterval = [[NSDate date] timeIntervalSinceReferenceDate] + D_DAY * days;
    NSDate *newDate = [NSDate dateWithTimeIntervalSinceReferenceDate:aTimeInterval];
    return newDate;
}

+ (NSDate *) dateWithDaysBeforeNow: (NSUInteger) days
{
    NSTimeInterval aTimeInterval = [[NSDate date] timeIntervalSinceReferenceDate] - D_DAY * days;
    NSDate *newDate = [NSDate dateWithTimeIntervalSinceReferenceDate:aTimeInterval];
    return newDate;
}

+ (NSDate *) dateTomorrow
{
    return [NSDate dateWithDaysFromNow:1];
}

+ (NSDate *) dateYesterday
{
    return [NSDate dateWithDaysBeforeNow:1];
}

+ (NSDate *) dateWithHoursFromNow: (NSUInteger) dHours
{
    NSTimeInterval aTimeInterval = [[NSDate date] timeIntervalSinceReferenceDate] + D_HOUR * dHours;
    NSDate *newDate = [NSDate dateWithTimeIntervalSinceReferenceDate:aTimeInterval];
    return newDate;
}

+ (NSDate *) dateWithHoursBeforeNow: (NSUInteger) dHours
{
    NSTimeInterval aTimeInterval = [[NSDate date] timeIntervalSinceReferenceDate] - D_HOUR * dHours;
    NSDate *newDate = [NSDate dateWithTimeIntervalSinceReferenceDate:aTimeInterval];
    return newDate;
}

+ (NSDate *) dateWithMinutesFromNow: (NSUInteger) dMinutes
{
    NSTimeInterval aTimeInterval = [[NSDate date] timeIntervalSinceReferenceDate] + D_MINUTE * dMinutes;
    NSDate *newDate = [NSDate dateWithTimeIntervalSinceReferenceDate:aTimeInterval];
    return newDate;
}

+ (NSDate *) dateWithMinutesBeforeNow: (NSUInteger) dMinutes
{
    NSTimeInterval aTimeInterval = [[NSDate date] timeIntervalSinceReferenceDate] - D_MINUTE * dMinutes;
    NSDate *newDate = [NSDate dateWithTimeIntervalSinceReferenceDate:aTimeInterval];
    return newDate;
}

#pragma mark Comparing Dates

- (NSString*)weiboStyle
{
    NSDate *now = [NSDate date];
    if ([self isToday])
    {
        NSInteger hoursBeforeNow = [self hoursBeforeDate:now];
        if (hoursBeforeNow < 1) // Less than one hour.
        {
            NSInteger minutesBeforeNow = [self minutesBeforeDate:now];
            if (minutesBeforeNow < 5) {
                return [NSString stringWithFormat:LocalStr(@"format_just_now")];
            } else {
                return [NSString stringWithFormat:LocalStr(@"format_minutes_before"), minutesBeforeNow];
            }
        }
        else
        {
            return [NSString stringWithFormat:LocalStr(@"format_hours_before"), hoursBeforeNow];
        }
        
        return [NSString stringWithFormat:LocalStr(@"format_today"), [NSDate convertDateToStringWithFormat:@"HH:mm" date:self]];
    }
    if ([self isThisYear]) {
        return [NSDate convertDateToStringWithFormat:@"MM-dd HH:mm" date:self];
    } else {
        return [NSDate convertDateToStringWithFormat:@"yyyy-MM-dd HH:mm" date:self];
    }
}

- (BOOL) isEqualToDateIgnoringTime: (NSDate *) aDate
{
    NSDateComponents *components1 = [CURRENT_CALENDAR components:DATE_COMPONENTS fromDate:self];
    NSDateComponents *components2 = [CURRENT_CALENDAR components:DATE_COMPONENTS fromDate:aDate];
    return (([components1 year] == [components2 year]) &&
            ([components1 month] == [components2 month]) &&
            ([components1 day] == [components2 day]));
}

- (BOOL) isToday
{
    return [self isEqualToDateIgnoringTime:[NSDate date]];
}

- (BOOL) isTomorrow
{
    return [self isEqualToDateIgnoringTime:[NSDate dateTomorrow]];
}

- (BOOL) isYesterday
{
    return [self isEqualToDateIgnoringTime:[NSDate dateYesterday]];
}

-(BOOL)isSameDate:(NSDate*)date
{
    return [self isEqualToDateIgnoringTime:date];
}

/**
 判断传入日期是否是本周
 逻辑修改: 传入日期跟本周一和本周日比较，在中间则返回true
 
 @param aDate 待判断日期
 @return 是否是本周
 */
- (BOOL) isSameWeekAsDate: (NSDate *) aDate
{
    NSCalendar *calendar = [NSCalendar currentCalendar];
    NSDateComponents *comp = [calendar components:NSCalendarUnitYear | NSCalendarUnitMonth | NSCalendarUnitDay | NSCalendarUnitWeekday | NSCalendarUnitDay fromDate:self];
    calendar.firstWeekday = 1;
    //    NSDateComponents *comp = [CURRENT_CALENDAR components:DATE_COMPONENTS fromDate:self];
    NSInteger weekDay = [comp weekday];
    NSInteger day = [comp day];
    NSLog(@"weekDay:%ld----day:%ld",(long)weekDay,(long)day);
    
    long firstDiff,lastDiff;
    if (weekDay == 1)
    {
        firstDiff = 1; //跟本周一差值
        lastDiff = 7; //跟本周日差值
    }
    else
    {
        firstDiff = [calendar firstWeekday] - weekDay;
        lastDiff = 8 - weekDay;
    }
    NSLog(@"firstDiff: %ld   lastDiff: %ld",firstDiff,lastDiff);
    
    // 在当前日期(去掉时分秒)基础上加上差的天数
    NSDateComponents *firstDayComp = [calendar components:NSCalendarUnitYear | NSCalendarUnitMonth | NSCalendarUnitDay  fromDate:self];
    [firstDayComp setDay:day + firstDiff];
    NSDate *firstDayOfWeek = [calendar dateFromComponents:firstDayComp];
    
    NSDateComponents *lastDayComp = [calendar components:NSCalendarUnitYear | NSCalendarUnitMonth | NSCalendarUnitDay   fromDate:self];
    [lastDayComp setDay:day + lastDiff];
    NSDate *lastDayOfWeek = [calendar dateFromComponents:lastDayComp];
    
    
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setDateFormat:@"MM月dd日"];
    NSString *firstDay = [formatter stringFromDate:firstDayOfWeek];
    NSString *lastDay = [formatter stringFromDate:lastDayOfWeek];
    NSString *aDataStr = [formatter stringFromDate:aDate];
    NSLog(@"周一：%@, 周日：%@, 比较日期：%@",firstDay,lastDay, aDataStr);
    
    if(aDate >= firstDayOfWeek && aDate <= lastDayOfWeek) {
        NSLog(@"在本周内");
        return YES;
    }
    NSLog(@"不在本周内");
    return NO;
    
    /* 原逻辑为7日内判断为本周
     NSDateComponents *components1 = [CURRENT_CALENDAR components:DATE_COMPONENTS fromDate:self];
     NSDateComponents *components2 = [CURRENT_CALENDAR components:DATE_COMPONENTS fromDate:aDate];
     
     // Must be same week. 12/31 and 1/1 will both be week "1" if they are in the same week
     if ([components1 weekOfYear] == [components2 weekOfYear]) return YES;
     
     // Must have a time interval under 1 week. Thanks @aclark
     return (fabs([self timeIntervalSinceDate:aDate]) < D_WEEK);
     */
}

- (BOOL) isThisWeek
{
    return [self isSameWeekAsDate:[NSDate date]];
}


/**
 是否是下周（以当天0点为时间节点做判断）
 
 @return 是否为下周
 */
- (BOOL) isNextWeek
{
    // 原逻辑为带时分秒时间+7天时间作为下周时间参数
    //    NSTimeInterval aTimeInterval = [[NSDate date] timeIntervalSinceReferenceDate] + D_WEEK;
    //    NSDate *newDate = [NSDate dateWithTimeIntervalSinceReferenceDate:aTimeInterval];
    
    //新逻辑为，把时分秒去掉，把当前日期0点+7天作为下周时间参数
    NSCalendar *calendar = [NSCalendar currentCalendar];
    NSDate *now = [NSDate date];
    NSDateComponents *components = [calendar components:NSCalendarUnitYear|NSCalendarUnitMonth|NSCalendarUnitDay fromDate:now];
    NSDate *startDate = [calendar dateFromComponents:components];
    NSTimeInterval aTimeInterval = [startDate timeIntervalSinceReferenceDate] + D_WEEK;
    NSDate *newDate = [NSDate dateWithTimeIntervalSinceReferenceDate:aTimeInterval];
    
    return [self isSameWeekAsDate:newDate];
}

- (BOOL) isLastWeek
{
    NSTimeInterval aTimeInterval = [[NSDate date] timeIntervalSinceReferenceDate] - D_WEEK;
    NSDate *newDate = [NSDate dateWithTimeIntervalSinceReferenceDate:aTimeInterval];
    return [self isSameWeekAsDate:newDate];
}

- (BOOL) isSameYearAsDate: (NSDate *) aDate
{
    NSDateComponents *components1 = [CURRENT_CALENDAR components:NSCalendarUnitYear fromDate:self];
    NSDateComponents *components2 = [CURRENT_CALENDAR components:NSCalendarUnitYear fromDate:aDate];
    return ([components1 year] == [components2 year]);
}

- (BOOL) isThisYear
{
    return [self isSameYearAsDate:[NSDate date]];
}

- (BOOL) isNextYear
{
    NSDateComponents *components1 = [CURRENT_CALENDAR components:NSCalendarUnitYear fromDate:self];
    NSDateComponents *components2 = [CURRENT_CALENDAR components:NSCalendarUnitYear fromDate:[NSDate date]];
    
    return ([components1 year] == ([components2 year] + 1));
}

- (BOOL) isLastYear
{
    NSDateComponents *components1 = [CURRENT_CALENDAR components:NSCalendarUnitYear fromDate:self];
    NSDateComponents *components2 = [CURRENT_CALENDAR components:NSCalendarUnitYear fromDate:[NSDate date]];
    
    return ([components1 year] == ([components2 year] - 1));
}

- (BOOL) isEarlierThanDate: (NSDate *) aDate
{
    return ([self earlierDate:aDate] == self);
}

- (BOOL) isLaterThanDate: (NSDate *) aDate
{
    return ([self laterDate:aDate] == self);
}


#pragma mark Adjusting Dates

- (NSDate *) dateByAddingDays: (NSUInteger) dDays
{
    NSTimeInterval aTimeInterval = [self timeIntervalSinceReferenceDate] + D_DAY * dDays;
    NSDate *newDate = [NSDate dateWithTimeIntervalSinceReferenceDate:aTimeInterval];
    return newDate;
}

- (NSDate *) dateBySubtractingDays: (NSUInteger) dDays
{
    return [self dateByAddingDays: (dDays * -1)];
}

- (NSDate *) dateByAddingHours: (NSUInteger) dHours
{
    NSTimeInterval aTimeInterval = [self timeIntervalSinceReferenceDate] + D_HOUR * dHours;
    NSDate *newDate = [NSDate dateWithTimeIntervalSinceReferenceDate:aTimeInterval];
    return newDate;
}

- (NSDate *) dateBySubtractingHours: (NSUInteger) dHours
{
    return [self dateByAddingHours: (dHours * -1)];
}

- (NSDate *) dateByAddingMinutes: (NSUInteger) dMinutes
{
    NSTimeInterval aTimeInterval = [self timeIntervalSinceReferenceDate] + D_MINUTE * dMinutes;
    NSDate *newDate = [NSDate dateWithTimeIntervalSinceReferenceDate:aTimeInterval];
    return newDate;
}

- (NSDate *) dateBySubtractingMinutes: (NSUInteger) dMinutes
{
    return [self dateByAddingMinutes: (dMinutes * -1)];
}

- (NSDate *) dateAtStartOfDay
{
    NSDateComponents *components = [CURRENT_CALENDAR components:DATE_COMPONENTS fromDate:self];
    [components setHour:0];
    [components setMinute:0];
    [components setSecond:0];
    return [CURRENT_CALENDAR dateFromComponents:components];
}

- (NSDateComponents *) componentsWithOffsetFromDate: (NSDate *) aDate
{
    NSDateComponents *dTime = [CURRENT_CALENDAR components:DATE_COMPONENTS fromDate:aDate toDate:self options:0];
    return dTime;
}

#pragma mark Retrieving Intervals

- (NSInteger) minutesAfterDate: (NSDate *) aDate
{
    NSTimeInterval ti = [self timeIntervalSinceDate:aDate];
    return (NSInteger) (ti / D_MINUTE);
}

- (NSInteger) minutesBeforeDate: (NSDate *) aDate
{
    NSTimeInterval ti = [aDate timeIntervalSinceDate:self];
    return (NSInteger) (ti / D_MINUTE);
}

- (NSInteger) hoursAfterDate: (NSDate *) aDate
{
    NSTimeInterval ti = [self timeIntervalSinceDate:aDate];
    return (NSInteger) (ti / D_HOUR);
}

- (NSInteger) hoursBeforeDate: (NSDate *) aDate
{
    NSTimeInterval ti = [aDate timeIntervalSinceDate:self];
    return (NSInteger) (ti / D_HOUR);
}

- (NSInteger) daysAfterDate: (NSDate *) aDate
{
    // get a midnight version of ourself:
    NSDateFormatter *mdf = [[NSDateFormatter alloc] init];
    [mdf setDateFormat:@"yyyy-MM-dd"];
    NSDate *midnight = [mdf dateFromString:[mdf stringFromDate:self]];
    NSDate* aDateMidnight = [mdf dateFromString:[mdf stringFromDate:aDate]];
    return (int)[midnight timeIntervalSinceDate:aDateMidnight] / (60*60*24);
}

- (NSInteger) daysBeforeDate: (NSDate *) aDate
{
    NSTimeInterval ti = [aDate timeIntervalSinceDate:self];
    return (NSInteger) (ti / D_DAY);
}

#pragma mark Decomposing Dates

- (NSInteger) nearestHour
{
    NSTimeInterval aTimeInterval = [[NSDate date] timeIntervalSinceReferenceDate] + D_MINUTE * 30;
    NSDate *newDate = [NSDate dateWithTimeIntervalSinceReferenceDate:aTimeInterval];
    NSDateComponents *components = [CURRENT_CALENDAR components:NSCalendarUnitHour fromDate:newDate];
    return [components hour];
}

- (NSInteger) hour
{
    NSDateComponents *components = [CURRENT_CALENDAR components:DATE_COMPONENTS fromDate:self];
    return [components hour];
}

- (NSInteger) minute
{
    NSDateComponents *components = [CURRENT_CALENDAR components:DATE_COMPONENTS fromDate:self];
    return [components minute];
}

- (NSInteger) seconds
{
    NSDateComponents *components = [CURRENT_CALENDAR components:DATE_COMPONENTS fromDate:self];
    return [components second];
}

- (NSInteger) day
{
    NSDateComponents *components = [CURRENT_CALENDAR components:DATE_COMPONENTS fromDate:self];
    return [components day];
}

- (NSInteger) month
{
    NSDateComponents *components = [CURRENT_CALENDAR components:DATE_COMPONENTS fromDate:self];
    return [components month];
}

- (NSInteger) week
{
    NSDateComponents *components = [CURRENT_CALENDAR components:DATE_COMPONENTS fromDate:self];
    return [components weekOfYear];
}

- (NSInteger) weekday
{
    NSDateComponents *components = [CURRENT_CALENDAR components:DATE_COMPONENTS fromDate:self];
    return [components weekday];
}

- (NSInteger) nthWeekday // e.g. 2nd Tuesday of the month is 2
{
    NSDateComponents *components = [CURRENT_CALENDAR components:DATE_COMPONENTS fromDate:self];
    return [components weekdayOrdinal];
}
- (NSInteger) year
{
    NSDateComponents *components = [CURRENT_CALENDAR components:DATE_COMPONENTS fromDate:self];
    return [components year];
}
@end

