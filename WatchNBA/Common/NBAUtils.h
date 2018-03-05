//
//  NBAUtils.h
//  WatchNBA
//
//  Created by tigi on 2018. 2. 27..
//  Copyright © 2018년 tigi. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NBAUtils : NSObject

+ (NSString *)todayEsternDate;
+ (NSString *)yesterdayEsternDate;
+ (NSString *)convertToLocaleDateFromUTCDateString:(NSString *)aUTCDateString format:(NSString *)aFormat;
@end
