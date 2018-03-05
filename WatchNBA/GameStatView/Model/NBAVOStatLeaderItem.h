//
//  NBAVOStatLeaderItem.h
//  WatchNBA
//
//  Created by tigi on 2018. 2. 28..
//  Copyright © 2018년 tigi. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "NBAVOPlayer.h"

@interface NBAVOStatLeaderItem : NSObject

@property(nonatomic, copy)NSString *value;
@property(nonatomic, strong)NSArray<NBAVOPlayer *> *players;

- (instancetype)initWithData:(NSDictionary *)aData;

@end
