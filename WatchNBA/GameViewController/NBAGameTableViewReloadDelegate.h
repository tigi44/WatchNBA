//
//  NBAGameTableViewReloadDelegate.h
//  WatchNBA
//
//  Created by tigi on 2018. 3. 5..
//  Copyright © 2018년 tigi. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol NBAGameTableViewReloadDelegate <NSObject>

- (void)reloadProgress:(float)aProgress;

@end
