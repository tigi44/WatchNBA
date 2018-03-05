//
//  NBAVOStatLeader.m
//  WatchNBA
//
//  Created by tigi on 2018. 2. 28..
//  Copyright © 2018년 tigi. All rights reserved.
//

#import "NBAVOStatLeader.h"

@implementation NBAVOStatLeader

- (instancetype)initWithData:(NSDictionary *)aData {
    self = [super init];
    if (self) {
        _points = [[NBAVOStatLeaderItem alloc] initWithData:aData[@"points"]];
        _rebounds = [[NBAVOStatLeaderItem alloc] initWithData:aData[@"rebounds"]];
        _assists = [[NBAVOStatLeaderItem alloc] initWithData:aData[@"assists"]];
    }
    return self;
}

@end
