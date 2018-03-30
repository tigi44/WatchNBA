//
//  NBAGameInfoTableViewCell.h
//  WatchNBA
//
//  Created by tigi on 2018. 2. 26..
//  Copyright © 2018년 tigi. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface NBAGameInfoTableViewCell : UITableViewCell

@property(nonatomic, readonly) UIProgressView   *reloadProgressView;
@property(nonatomic, readonly) UIImageView      *vTeamLogoImageView;
@property(nonatomic, readonly) UIImageView      *hTeamLogoImageView;
@property(nonatomic, readonly) UILabel          *vTeamTriCodeLabel;
@property(nonatomic, readonly) UILabel          *hTeamTriCodeLabel;
@property(nonatomic, readonly) UILabel          *vTeamScoreLabel;
@property(nonatomic, readonly) UILabel          *hTeamScoreLabel;

@property(nonatomic, readonly) UILabel          *gameTimeLabel;
@property(nonatomic, readonly) UILabel          *gameClockLabel;

@property(nonatomic, readonly) UILabel          *startDateLabel;

@property(nonatomic, readonly) UIButton         *moveNbaSiteButton;

+ (float)tableViewCellHeight;
@end
