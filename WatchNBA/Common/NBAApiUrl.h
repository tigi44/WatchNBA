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

static const NSInteger gNbaApiReloadTime = 10;

#define NBA_DOMAIN @"https://data.nba.net"

#define NBA_TODAY_API @"https://data.nba.net/prod/v3/today.json"

#define NBA_TODAY_EST_SCOREBOARD_API [NSString stringWithFormat:@"https://data.nba.net/prod/v2/%@/scoreboard.json", [NBAUtils todayEsternDate]];
#define NBA_YESTERDAY_EST_SCOREBOARD_API [NSString stringWithFormat:@"https://data.nba.net/prod/v2/%@/scoreboard.json", [NBAUtils yesterdayEsternDate]];

#define NBA_BOX_SCORE_API(aGameDate, aGameId) [NSString stringWithFormat:@"https://data.nba.net/prod/v1/%@/%@_boxscore.json", aGameDate, aGameId];
#define NBA_TEAM_LOGO_IMG_URL(aTeamCode) [NSString stringWithFormat:@"https://neulionms-a.akamaihd.net/nba/player/v1/nba/site/images/teams/%@_p.png", aTeamCode];
#define NBA_PLAYER_IMG_URL(aPlayerId) [NSString stringWithFormat:@"https://neulionmdnyc-a.akamaihd.net/nba/media/img/players/head/132x132/%@.png", aPlayerId];
#define NBA_PLAYER_MULTI_IMG_URL @"https://neulionms-a.akamaihd.net/nba/player/v1/nba/site_4/images/multipleplayer.png";

#endif /* NBAApiUrl_h */
