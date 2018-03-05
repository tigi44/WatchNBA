//
//  NBAVOStat.m
//  WatchNBA
//
//  Created by tigi on 2018. 2. 28..
//  Copyright © 2018년 tigi. All rights reserved.
//

#import "NBAVOStat.h"

@implementation NBAVOStat

- (instancetype)initWithData:(NSDictionary *)aData {
    self = [super init];
    if (self) {
        _timesTied = aData[@"timeTied"];
        _leadChanged = aData[@"leadChanged"];
        _vTeam = [[NBAVOStatTeam alloc] initWithData:aData[@"vTeam"]];
        _hTeam = [[NBAVOStatTeam alloc] initWithData:aData[@"hTeam"]];
    }
    return self;
}

- (instancetype)init {
    return [self initWithData:nil];
}

@end
