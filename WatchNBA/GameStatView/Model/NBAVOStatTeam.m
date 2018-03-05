//
//  NBAVOStatTeam.m
//  WatchNBA
//
//  Created by tigi on 2018. 2. 28..
//  Copyright © 2018년 tigi. All rights reserved.
//

#import "NBAVOStatTeam.h"

@implementation NBAVOStatTeam

- (instancetype)initWithData:(NSDictionary *)aData {
    self = [super init];
    if (self) {
        _leaders = [[NBAVOStatLeader alloc] initWithData:aData[@"leaders"]];
    }
    return self;
}

- (instancetype)init {
    return [self initWithData:nil];
}

@end
