//
//  NBAVOGame.h
//  WatchNBA
//
//  Created by tigi on 2018. 2. 28..
//  Copyright © 2018년 tigi. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "NBAVOPeriod.h"
#import "NBAVOTeam.h"

@interface NBAVOGame : NSObject

@property(nonatomic, copy)                              NSString    *gameId;
@property(nonatomic, assign, getter=isGameActivated)    BOOL        gameActivated;
@property(nonatomic, copy)                              NSString    *startTimeEastern;
@property(nonatomic, copy)                              NSString    *startTimeUTC;
@property(nonatomic, copy)                              NSString    *endTimeUTC;
@property(nonatomic, copy)                              NSString    *startDateEastern;
@property(nonatomic, copy)                              NSString    *clock;
@property(nonatomic, strong)                            NBAVOPeriod *period;
@property(nonatomic, strong)                            NBAVOTeam   *vTeam;
@property(nonatomic, strong)                            NBAVOTeam   *hTeam;

- (instancetype)initWithData:(NSDictionary *)aGamedata;

- (BOOL)isGameEnded;

@end
