//
//  NBANoGameTableViewCell.h
//  WatchNBA
//
//  Created by tigi on 2018. 2. 26..
//  Copyright © 2018년 tigi. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface NBANoGameTableViewCell : UITableViewCell

@property(nonatomic, readonly) UILabel *noGameLabel;

+ (float)tableViewCellHeight;

@end
