//
//  NBAVOStatLeaderItem.m
//  WatchNBA
//
//  Created by tigi on 2018. 2. 28..
//  Copyright © 2018년 tigi. All rights reserved.
//

#import "NBAVOStatLeaderItem.h"

@implementation NBAVOStatLeaderItem

- (instancetype)initWithData:(NSDictionary *)aData {
    self = [super init];
    if (self) {
        _value = aData[@"value"];
        _players = [NSArray array];
        for (NSDictionary *player in aData[@"players"]) {
            _players = [_players arrayByAddingObject:[[NBAVOPlayer alloc] initWithData:player]];
        }
    }
    return self;
}

- (instancetype)init {
    return [self initWithData:nil];
}

@end
