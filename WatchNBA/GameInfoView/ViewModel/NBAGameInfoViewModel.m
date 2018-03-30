//
//  NBAGameInfoViewModel.m
//  WatchNBA
//
//  Created by tigi on 2018. 2. 26..
//  Copyright © 2018년 tigi. All rights reserved.
//

#import "NBAGameInfoViewModel.h"
#import "NBAGameInfoTableViewCell.h"
#import "NBAApiUrl.h"
#import "UIImageView+WebImage.h"

@implementation NBAGameInfoViewModel {
    NSString *_gameId;
    
    NSString *_vTeamLogoImageUrl;
    NSString *_hTeamLogoImageUrl;
    
    NSString *_vTeamTriCode;
    NSString *_hTeamTriCode;
    
    NSString *_vTeamScore;
    NSString *_hTeamScore;
    
    NSString *_gameTime;
    NSString *_gameClock;
    
    NSString *_startDate;
    NSString *_startDateEastern;
    
    UIProgressView *_reloadProgressView;
    
    BOOL _isGameActivated;
    BOOL _isGameEnded;
}

- (instancetype)initWithGame:(NBAVOGame *)aGame {
    self = [super init];
    if (self) {
        _isGameEnded        = [aGame isGameEnded];
        _isGameActivated    = [aGame isGameActivated];
        
        _gameId             = [aGame gameId];
        _startDateEastern   = [aGame startDateEastern];
        _startDate          = [NBAUtils convertToLocaleDateFromUTCDateString:[aGame startTimeUTC] format:@"yyyy/MM/dd"];
        _gameTime           = [NBAUtils convertToLocaleDateFromUTCDateString:[aGame startTimeUTC] format:@"HH:mm"];
        _gameClock          = [aGame clock];
        
        _vTeamTriCode       = [[aGame vTeam] triCode];
        _hTeamTriCode       = [[aGame hTeam] triCode];
        
        _vTeamScore         = [[aGame vTeam] score];
        _hTeamScore         = [[aGame hTeam] score];
        
        _vTeamLogoImageUrl  = NBA_TEAM_LOGO_IMG_URL(_vTeamTriCode);
        _hTeamLogoImageUrl  = NBA_TEAM_LOGO_IMG_URL(_hTeamTriCode);
        
        if ([aGame isGameEnded]) {
            _gameTime = @"END of GAME";
        }
        if ([aGame isGameActivated]) {
            if ([[aGame period] isHalftime]) {
                _gameTime = @"Half Time";
            } else if ([[aGame period] isEndOfPeriod]) {
                _gameTime = [NSString stringWithFormat:@"END of Q%ld", [[aGame period] current]];
            } else {
                _gameTime = [NSString stringWithFormat:@"Q%ld", [[aGame period] current]];
            }
        }
    }
    return self;
}

- (instancetype)init {
    return [self initWithGame:nil];
}

#pragma mark - Implementation NBAGameTableViewModelProtocol

+ (Class)tableViewCellClass {
    return [NBAGameInfoTableViewCell class];
}

- (UITableViewCell *)tableView:(UITableView *)aTableView cellForRowAtIndexPath:(NSIndexPath *)aIndexPath { 
    NBAGameInfoTableViewCell *sTabelViewCell = [aTableView dequeueReusableCellWithIdentifier:NSStringFromClass([[self class] tableViewCellClass])];
    [sTabelViewCell setSeparatorInset:UIEdgeInsetsZero];
    [sTabelViewCell setLayoutMargins:UIEdgeInsetsZero];
    
    [[sTabelViewCell vTeamTriCodeLabel] setText:_vTeamTriCode];
    [[sTabelViewCell hTeamTriCodeLabel] setText:_hTeamTriCode];
    
    [[sTabelViewCell vTeamScoreLabel] setText:_vTeamScore];
    [[sTabelViewCell hTeamScoreLabel] setText:_hTeamScore];
    
    [[sTabelViewCell vTeamLogoImageView] setImageWithURLString:_vTeamLogoImageUrl
                                         placeholderImage:[UIImage imageNamed:@"nba_logo.png"]
                                            loadFailImage:[UIImage imageNamed:@"default_player.png"]
                                                   option:WebImageOptionAFNetworking
                                                completed:^(NSURL * _Nullable imageURL, UIImage * _Nullable image, NSError * _Nullable error) {
                                                    if (error) {
                                                    } else {
                                                    }
                                                }];
    
    [[sTabelViewCell hTeamLogoImageView] setImageWithURLString:_hTeamLogoImageUrl
                                         placeholderImage:[UIImage imageNamed:@"nba_logo.png"]
                                            loadFailImage:[UIImage imageNamed:@"default_player.png"]
                                                   option:WebImageOptionSDWebImage
                                                completed:^(NSURL * _Nullable imageURL, UIImage * _Nullable image, NSError * _Nullable error) {
                                                    if (error) {
                                                    } else {
                                                    }
                                                }];
    
    [[sTabelViewCell gameTimeLabel] setText:_gameTime];
    [[sTabelViewCell gameClockLabel] setText:_gameClock];
    [[sTabelViewCell startDateLabel] setText:_startDate];
    
    [[sTabelViewCell moveNbaSiteButton] addTarget:self action:@selector(moveToNbaSite) forControlEvents:UIControlEventTouchUpInside];
    
    _reloadProgressView = [sTabelViewCell reloadProgressView];
    [sTabelViewCell setNeedsLayout];
    
    return sTabelViewCell;
}

- (CGFloat)tableView:(UITableView *)aTableView heightForRowAtIndexPath:(NSIndexPath *)aIndexPath {
    return [[[self class] tableViewCellClass] tableViewCellHeight];
}

#pragma mark - Implementation NBAGameTableViewReloadDelegate

- (void)reloadProgress:(float)aProgress{
//    NBADebugLog(@"reload GameId : %@ - %f", _gameId, aProgress);
    [_reloadProgressView setProgress:aProgress];
}

#pragma mark - UIButton Target

- (void)moveToNbaSite
{
    NSString *sURLString = [NSString stringWithFormat:NBA_GAME_SITE_URL, _startDateEastern, _vTeamTriCode, _hTeamTriCode];
    [self.presentSafariDelegate presentSafariViewControllerWithURL:[NSURL URLWithString:sURLString]];
}

@end
