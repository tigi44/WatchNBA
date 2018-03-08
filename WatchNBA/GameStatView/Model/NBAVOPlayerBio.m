//
//  NBAVOPlayerBio.m
//  WatchNBA
//
//  Created by tigi on 2018. 3. 8..
//  Copyright © 2018년 tigi. All rights reserved.
//

#import "NBAVOPlayerBio.h"

@implementation NBAVOPlayerBio

- (instancetype)initWithData:(NSDictionary *)aData {
    self = [super init];
    if (self) {
        _playerId = aData[@"id"];
        _playerName = aData[@"display_name"];
        _professional = aData[@"professional"];
        _colleage = aData[@"colleage"];
        _highschool = aData[@"highschool"];
        _twitter = aData[@"twitter"];
    }
    return self;
}

- (instancetype)init {
    return [self initWithData:nil];
}

@end
