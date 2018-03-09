//
//  NBAGameInfoTableViewCell.m
//  WatchNBA
//
//  Created by tigi on 2018. 2. 26..
//  Copyright © 2018년 tigi. All rights reserved.
//

#import "NBAGameInfoTableViewCell.h"
#import "UIView+Layout.h"
#import "NBAApiUrl.h"

static const CGPoint kLogoImagePoint = {20.f, 100.f};
static const CGSize kLogoImageSize = {100.f, 100.f};
static const float kLogoImageGap = 10.f;

@interface NBAGameInfoTableViewCell()

@property(nonatomic, readwrite)UIProgressView *reloadProgressView;
@property(nonatomic, readwrite) UIImageView *vTeamLogoImageView;
@property(nonatomic, readwrite) UIImageView *hTeamLogoImageView;
@property(nonatomic, readwrite) UILabel *vTeamTriCodeLabel;
@property(nonatomic, readwrite) UILabel *hTeamTriCodeLabel;
@property(nonatomic, readwrite) UILabel *vTeamScoreLabel;
@property(nonatomic, readwrite) UILabel *hTeamScoreLabel;

@property(nonatomic, readwrite) UILabel *gameTimeLabel;
@property(nonatomic, readwrite) UILabel *gameClockLabel;

@property(nonatomic, readwrite) UILabel *startDateLabel;

@end

@implementation NBAGameInfoTableViewCell

- (instancetype)initWithStyle:(UITableViewCellStyle)aStyle reuseIdentifier:(NSString *)aReuseIdentifier {
    self = [super initWithStyle:aStyle reuseIdentifier:aReuseIdentifier];
    if (self) {
        [self setBackgroundColor:COLOR_BACKGROUND];
        [self setupSubview];
    }
    return self;
}

- (void) layoutSubviews {
    [super layoutSubviews];
    
    [_reloadProgressView setSize:CGSizeMake([self bounds].size.width, 10.f)];
    [_reloadProgressView setPosition:CGPointMake(0, [self bounds].size.height)];
    
    [_vTeamLogoImageView setSize:kLogoImageSize];
    [_vTeamLogoImageView moveToVerticalCenter];
    [_vTeamLogoImageView setPosition:kLogoImagePoint];
    
    [_hTeamLogoImageView setSize:kLogoImageSize];
    [_hTeamLogoImageView moveToVerticalCenter];
    [_hTeamLogoImageView moveToRightWithMargin:kLogoImagePoint.x];
    [_hTeamLogoImageView setYPosition:kLogoImagePoint.y];
    
    [_vTeamTriCodeLabel sizeToFit];
    [_vTeamTriCodeLabel setXPosition:kLogoImageSize.width/2 + kLogoImagePoint.x - [_vTeamTriCodeLabel frame].size.width/2];
    [_vTeamTriCodeLabel moveToBottomOf:_vTeamLogoImageView gap:kLogoImageGap];

    [_hTeamTriCodeLabel sizeToFit];
    [_hTeamTriCodeLabel moveToRightWithMargin:kLogoImageSize.width/2 + kLogoImagePoint.x - [_hTeamTriCodeLabel frame].size.width/2];
    [_hTeamTriCodeLabel moveToBottomOf:_hTeamLogoImageView gap:kLogoImageGap];
    
    [_vTeamScoreLabel sizeToFit];
    [_vTeamScoreLabel setXPosition:kLogoImageSize.width/2 + kLogoImagePoint.x - [_vTeamScoreLabel frame].size.width/2];
    [_vTeamScoreLabel moveToBottomOf:_vTeamTriCodeLabel gap:kLogoImageGap];
    
    [_hTeamScoreLabel sizeToFit];
    [_hTeamScoreLabel moveToRightWithMargin:kLogoImageSize.width/2 + kLogoImagePoint.x - [_hTeamScoreLabel frame].size.width/2];
    [_hTeamScoreLabel moveToBottomOf:_hTeamTriCodeLabel gap:kLogoImageGap];
    
    [_gameTimeLabel sizeToFit];
    [_gameTimeLabel setWidth:75.f];
    [_gameTimeLabel moveToHorizontalCenter];
    [_gameTimeLabel setYPosition:kLogoImagePoint.y + kLogoImageSize.height/2 - kLogoImageGap];
    
    [_gameClockLabel sizeToFit];
    [_gameClockLabel moveToHorizontalCenter];
    [_gameClockLabel moveToBottomOf:_gameTimeLabel gap:kLogoImageGap];
    
    [_startDateLabel sizeToFit];
    [_startDateLabel moveToHorizontalCenter];
    [_startDateLabel setYPosition:kLogoImagePoint.y/2];
    
}

- (void)setupSubview {
    _reloadProgressView = [[UIProgressView alloc] initWithFrame:CGRectZero];
    [_reloadProgressView setTrackTintColor:COLOR_STATIC];
    [_reloadProgressView setTintColor:COLOR_CLOCK];
    [[self contentView] addSubview:_reloadProgressView];
    
    _vTeamLogoImageView = [[UIImageView alloc] initWithFrame:CGRectZero];
    [_vTeamLogoImageView setContentMode:UIViewContentModeScaleAspectFill];
    [[self contentView] addSubview:_vTeamLogoImageView];
    
    _hTeamLogoImageView = [[UIImageView alloc] initWithFrame:CGRectZero];
    [_hTeamLogoImageView setContentMode:UIViewContentModeScaleAspectFill];
    [[self contentView] addSubview:_hTeamLogoImageView];
    
    _vTeamTriCodeLabel = [[UILabel alloc] initWithFrame:CGRectZero];
    [_vTeamTriCodeLabel setNumberOfLines:1];
    [_vTeamTriCodeLabel setFont:[UIFont boldSystemFontOfSize:20.0f]];
    [_vTeamTriCodeLabel setTextColor:COLOR_STATIC];
    [[self contentView] addSubview:_vTeamTriCodeLabel];
    
    _hTeamTriCodeLabel = [[UILabel alloc] initWithFrame:CGRectZero];
    [_hTeamTriCodeLabel setNumberOfLines:1];
    [_hTeamTriCodeLabel setFont:[UIFont boldSystemFontOfSize:20.0f]];
    [_hTeamTriCodeLabel setTextColor:COLOR_STATIC];
    [[self contentView] addSubview:_hTeamTriCodeLabel];
    
    _vTeamScoreLabel = [[UILabel alloc] initWithFrame:CGRectZero];
    [_vTeamScoreLabel setNumberOfLines:1];
    [_vTeamScoreLabel setFont:[UIFont boldSystemFontOfSize:24.0f]];
    [_vTeamScoreLabel setTextColor:COLOR_TEXT];
    [[self contentView] addSubview:_vTeamScoreLabel];
    
    _hTeamScoreLabel = [[UILabel alloc] initWithFrame:CGRectZero];
    [_hTeamScoreLabel setNumberOfLines:1];
    [_hTeamScoreLabel setFont:[UIFont boldSystemFontOfSize:24.0f]];
    [_hTeamScoreLabel setTextColor:COLOR_TEXT];
    [[self contentView] addSubview:_hTeamScoreLabel];
    
    _gameTimeLabel = [[UILabel alloc] initWithFrame:CGRectZero];
    [_gameTimeLabel setNumberOfLines:2];
    [_gameTimeLabel setFont:[UIFont boldSystemFontOfSize:20.0f]];
    [_gameTimeLabel setTextColor:COLOR_STATIC];
    [_gameTimeLabel setTextAlignment:NSTextAlignmentCenter];
    [[self contentView] addSubview:_gameTimeLabel];
    
    _gameClockLabel = [[UILabel alloc] initWithFrame:CGRectZero];
    [_gameClockLabel setNumberOfLines:1];
    [_gameClockLabel setFont:[UIFont boldSystemFontOfSize:20.0f]];
    [_gameClockLabel setTextColor:COLOR_CLOCK];
    [_gameClockLabel setTextAlignment:NSTextAlignmentCenter];
    [[self contentView] addSubview:_gameClockLabel];
    
    _startDateLabel = [[UILabel alloc] initWithFrame:CGRectZero];
    [_startDateLabel setNumberOfLines:1];
    [_startDateLabel setFont:[UIFont boldSystemFontOfSize:24.0f]];
    [_startDateLabel setTextColor:COLOR_STATIC];
    [[self contentView] addSubview:_startDateLabel];
    
}

- (void)prepareForReuse {
    [super prepareForReuse];
    [_reloadProgressView setProgress:0];
    [_vTeamLogoImageView setImage:nil];
    [_hTeamLogoImageView setImage:nil];
    [_vTeamTriCodeLabel setText:@""];
    [_hTeamTriCodeLabel setText:@""];
    [_vTeamScoreLabel setText:@""];
    [_hTeamScoreLabel setText:@""];
    
    [_gameTimeLabel setText:@""];
    [_gameClockLabel setText:@""];
    
    [_startDateLabel setText:@""];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

#pragma mark -

+ (float)tableViewCellHeight {
    return [[UIScreen mainScreen] bounds].size.height * 1.2 / 3;
}

@end
