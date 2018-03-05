//
//  NBAVOPeriod.h
//  WatchNBA
//
//  Created by tigi on 2018. 2. 28..
//  Copyright © 2018년 tigi. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NBAVOPeriod : NSObject

@property(nonatomic, assign)NSInteger current;
@property(nonatomic, assign)NSInteger type;
@property(nonatomic, assign)NSInteger maxRegular;
@property(nonatomic, assign, getter=isHalftime)BOOL halftime;
@property(nonatomic, assign, getter=isEndOfPeriod)BOOL endOfPeriod;

- (instancetype)initWithData:(NSDictionary *)aPeriodData;

@end
