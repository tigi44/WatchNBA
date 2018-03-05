//
//  NBAVOStatTeam.h
//  WatchNBA
//
//  Created by tigi on 2018. 2. 28..
//  Copyright © 2018년 tigi. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "NBAVOStatLeader.h"

@interface NBAVOStatTeam : NSObject

@property(nonatomic, strong)NBAVOStatLeader *leaders;

- (instancetype)initWithData:(NSDictionary *)aData;

@end
