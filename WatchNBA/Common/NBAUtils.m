//
//  NBAUtils.m
//  WatchNBA
//
//  Created by tigi on 2018. 2. 27..
//  Copyright © 2018년 tigi. All rights reserved.
//

#import "NBAUtils.h"

@implementation NBAUtils

+ (NSString *)todayEsternDate {
    NSTimeZone *sTimeZone = [NSTimeZone timeZoneWithAbbreviation:@"EST"];
    NSDateFormatter *sDateFormatter=[[NSDateFormatter alloc] init];
    [sDateFormatter setTimeZone:sTimeZone];
    [sDateFormatter setDateFormat:@"yyyyMMdd"];
    
    return [sDateFormatter stringFromDate:[NSDate date]];
}

+ (NSString *)yesterdayEsternDate {
    NSTimeZone *sTimeZone = [NSTimeZone timeZoneWithAbbreviation:@"EST"];
    NSDateFormatter *sDateFormatter=[[NSDateFormatter alloc] init];
    [sDateFormatter setTimeZone:sTimeZone];
    [sDateFormatter setDateFormat:@"yyyyMMdd"];
    
    return [sDateFormatter stringFromDate:[NSDate dateWithTimeIntervalSinceNow: -(60.0f*60.0f*24.0f)]];
}

+ (NSString *)convertToLocaleDateFromUTCDateString:(NSString *)aUTCDateString format:(NSString *)aFormat {
    NSDateFormatter *sDateFormatter = [[NSDateFormatter alloc] init];
    [sDateFormatter setDateFormat:@"yyyy-MM-dd'T'HH:mm:ss.SSSZ"];
    [sDateFormatter setLocale:[[NSLocale alloc] initWithLocaleIdentifier:@"UTC"]];
    NSDate *sDateUTC = [sDateFormatter dateFromString:aUTCDateString];
    
    sDateFormatter = [[NSDateFormatter alloc] init];
    [sDateFormatter setDateFormat:aFormat];
    
    return [sDateFormatter stringFromDate:sDateUTC];
}

@end
