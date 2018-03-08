//
//  NBAGameStatCollectionViewCell.h
//  WatchNBA
//
//  Created by tigi on 2018. 2. 27..
//  Copyright © 2018년 tigi. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef NS_ENUM(NSUInteger, NBAGameStatCollectionViewCellImageSideOption)
{
    ImageSideNone = 0,
    ImageSideLeft,
    ImageSideRight
};

@interface NBAGameStatCollectionViewCell : UICollectionViewCell

@property(nonatomic, readonly)UILabel *valueLabel;
@property(nonatomic, readonly)UIImageView *playerImageView;
@property(nonatomic, readonly)UILabel *playerNameLabel;
@property(nonatomic, assign)NBAGameStatCollectionViewCellImageSideOption imageSideOption;

@end
