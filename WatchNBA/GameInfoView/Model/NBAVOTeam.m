//
//  NBAVOTeam.m
//  WatchNBA
//
//  Created by tigi on 2018. 2. 28..
//  Copyright © 2018년 tigi. All rights reserved.
//

#import "NBAVOTeam.h"

@implementation NBAVOTeam

- (instancetype)initWithData:(NSDictionary *)aTeamData {
    self = [super init];
    if (self) {
        _teamId = aTeamData[@"teamId"];
        _triCode = aTeamData[@"triCode"];
        _win = aTeamData[@"win"];
        _loss = aTeamData[@"loss"];
        _seriesWin = aTeamData[@"seriesWin"];
        _seriesLoss = aTeamData[@"seriesLoss"];
        _score = aTeamData[@"score"];
    }
    return self;
}

- (instancetype)init {
    return [self initWithData:nil];
}

@end
