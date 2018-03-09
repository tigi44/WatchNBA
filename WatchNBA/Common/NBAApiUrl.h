//
//  NBAApiUrl.h
//  WatchNBA
//
//  Created by tigi on 2018. 2. 21..
//  Copyright © 2018년 tigi. All rights reserved.
//

#ifndef NBAApiUrl_h
#define NBAApiUrl_h

#import "NBAUtils.h"

#define DebugLog 1

#if DEBUG && DebugLog
#   define NBADebugLog(fmt, ...) NSLog((@"%s [Line %d] " fmt), __PRETTY_FUNCTION__, __LINE__, ##__VA_ARGS__);
#else
#   define NBADebugLog(...)
#endif

static const NSInteger gNbaApiReloadTime = 10;

#define COLOR_BACKGROUND    [UIColor whiteColor]
#define COLOR_STATIC        [UIColor grayColor]
#define COLOR_TEXT          [UIColor blackColor]
#define COLOR_CLOCK         [UIColor redColor]


#define NBA_DOMAIN @"https://data.nba.net"

#define NBA_TODAY_API @"https://data.nba.net/prod/v3/today.json"

#define NBA_TODAY_EST_SCOREBOARD_API [NSString stringWithFormat:@"https://data.nba.net/prod/v2/%@/scoreboard.json", [NBAUtils todayDateEST]];
#define NBA_YESTERDAY_EST_SCOREBOARD_API [NSString stringWithFormat:@"https://data.nba.net/prod/v2/%@/scoreboard.json", [NBAUtils yesterdayDateEST]];

#define NBA_TODAY_UTC_SCOREBOARD_API_PATH [NSString stringWithFormat:@"/prod/v2/%@/scoreboard.json", [NBAUtils todayDateUTC]];

#define NBA_BOX_SCORE_API(aGameDate, aGameId) [NSString stringWithFormat:@"https://data.nba.net/prod/v1/%@/%@_boxscore.json", aGameDate, aGameId];
#define NBA_PLAYER_BIO_API(aPlayerId) [NSString stringWithFormat:@"https://data.nba.net/json/bios/player_%@.json", aPlayerId];

#define NBA_TEAM_LOGO_IMG_URL(aTeamCode) [NSString stringWithFormat:@"https://neulionms-a.akamaihd.net/nba/player/v1/nba/site/images/teams/%@_p.png", aTeamCode];
#define NBA_PLAYER_MULTI_IMG_URL @"https://neulionms-a.akamaihd.net/nba/player/v1/nba/site_4/images/multipleplayer.png";
#define NBA_PLAYER_IMG_URL(aPlayerId) (aPlayerId) ? [NSString stringWithFormat:@"https://neulionmdnyc-a.akamaihd.net/nba/media/img/players/head/132x132/%@.png", aPlayerId] : NBA_PLAYER_MULTI_IMG_URL;

#endif /* NBAApiUrl_h */
