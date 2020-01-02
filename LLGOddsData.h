//
//  LLGOddsData.h
//  LLottery
//
//  Created by Sujiewen on 17/3/24.
//  Copyright © 2017年  Sjw. All rights reserved.
//

#import <Foundation/Foundation.h>


typedef NS_ENUM(NSInteger, OddsType) {
    Odds_BLEND,       //混合 ZQHH
    Odds_SPF,         //胜平负 SPF
    Odds_RQSPF,       //让球胜平负 RQSPF
    Odds_TotalGoal,   //总进球 JQS
    Odds_Score,       //比分 BF
    Odds_DoubleResult,//半全场 BQC
};

@interface LLGOddsData : NSObject

+ (NSArray *)getOddsBFArray;
+ (NSArray *)getOddsJQSArray;
+ (NSArray *)getOddsSubmitJQSArray;
+ (NSArray *)getOddsBQCArray;
+ (NSArray *)getOddsSubmitBQCArray;

+ (NSInteger) getStrWeekInt:(NSString *)week;
+ (NSString *)getGameingWayType:(OddsType)oddsType;

@end
