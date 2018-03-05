//
//  NBAVOPlayer.m
//  WatchNBA
//
//  Created by tigi on 2018. 2. 28..
//  Copyright © 2018년 tigi. All rights reserved.
//

#import "NBAVOPlayer.h"

@implementation NBAVOPlayer

- (instancetype)initWithData:(NSDictionary *)aPersonData {
    self = [super init];
    if (self) {
        _personId = aPersonData[@"personId"];
    }
    return self;
}

- (instancetype)init {
    return [self initWithData:nil];
}

@end
