//
//  NBAVOGame.m
//  WatchNBA
//
//  Created by tigi on 2018. 2. 28..
//  Copyright © 2018년 tigi. All rights reserved.
//

#import "NBAVOGame.h"

@implementation NBAVOGame

- (instancetype)initWithData:(NSDictionary *)aGamedata {
    self = [super init];
    if (self) {
        _gameId = aGamedata[@"gameId"];
        _gameActivated = [aGamedata[@"isGameActivated"] boolValue];
        _startTimeEastern = aGamedata[@"startTimeEastern"];
        _startTimeUTC = aGamedata[@"startTimeUTC"];
        _endTimeUTC = aGamedata[@"endTimeUTC"];
        _startDateEastern = aGamedata[@"startDateEastern"];
        _clock = aGamedata[@"clock"];
        _period = [[NBAVOPeriod alloc] initWithData:aGamedata[@"period"]];
        _vTeam = [[NBAVOTeam alloc] initWithData:aGamedata[@"vTeam"]];
        _hTeam = [[NBAVOTeam alloc] initWithData:aGamedata[@"hTeam"]];
    }
    return self;
}

- (instancetype)init {
    return [self initWithData:nil];
}

- (BOOL)isGameEnded {
    if (_endTimeUTC) {
        return YES;
    }
    return NO;
}

@end
