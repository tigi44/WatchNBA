//
//  NBAGameViewController.h
//  WatchNBA
//
//  Created by tigi on 2018. 2. 21..
//  Copyright © 2018년 tigi. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "NBAVOGame.h"
#import "NBAVOStat.h"

@interface NBAGameViewController : UIViewController

@property(nonatomic, assign, readonly) NSInteger index;

- (instancetype)initWithGame:(NBAVOGame *)aGame index:(NSInteger)aIndex;

@end
