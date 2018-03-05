//
//  NBAVOPeriod.m
//  WatchNBA
//
//  Created by tigi on 2018. 2. 28..
//  Copyright © 2018년 tigi. All rights reserved.
//

#import "NBAVOPeriod.h"

@implementation NBAVOPeriod

- (instancetype)initWithData:(NSDictionary *)aPeriodData {
    self = [super init];
    if (self) {
        _current = [aPeriodData[@"current"] intValue];
        _type = [aPeriodData[@"type"] intValue];
        _maxRegular = [aPeriodData[@"maxRegular"] intValue];
        _halftime = [aPeriodData[@"isHalftime"] boolValue];
        _endOfPeriod = [aPeriodData[@"isEndOfPeriod"] boolValue];
    }
    return self;
}

- (instancetype)init {
    return [self initWithData:nil];
}

@end
