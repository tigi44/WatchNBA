//
//  NBAVOStatLeader.h
//  WatchNBA
//
//  Created by tigi on 2018. 2. 28..
//  Copyright © 2018년 tigi. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "NBAVOStatLeaderItem.h"

@interface NBAVOStatLeader : NSObject

@property(nonatomic, strong)NBAVOStatLeaderItem *points;
@property(nonatomic, strong)NBAVOStatLeaderItem *rebounds;
@property(nonatomic, strong)NBAVOStatLeaderItem *assists;

- (instancetype)initWithData:(NSDictionary *)aData;

@end
