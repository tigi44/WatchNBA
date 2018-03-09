//
//  NBAGameViewController.h
//  WatchNBA
//
//  Created by tigi on 2018. 2. 21..
//  Copyright © 2018년 tigi. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface NBAGameViewController : UIViewController

@property(nonatomic, assign, readonly) NSInteger index;

- (instancetype)initWithGameData:(NSDictionary *)aData index:(NSInteger)aIndex NS_DESIGNATED_INITIALIZER;

@end
