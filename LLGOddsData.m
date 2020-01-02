//
//  LLGOddsData.m
//  LLottery
//
//  Created by Sujiewen on 17/3/24.
//  Copyright © 2017年  Sjw. All rights reserved.
//

#import "LLGOddsData.h"

NSArray *bfArray = NULL;
NSArray *jqsArray = NULL;
NSArray *bqcArray = NULL;
NSArray *bqcSArray = NULL;
NSArray *jqsSArray = NULL;

@interface LLGOddsData ()



@end

@implementation LLGOddsData

+ (NSArray*)getOddsBFArray {
    if(bfArray == NULL) {
        bfArray = @[@"1:0",@"2:0",@"2:1",@"3:0",@"3:1",@"3:2",@"4:0",@"4:1",@"4:2",@"5:0",@"5:1",@"5:2",@"胜其他",
                        @"0:0",@"1:1",@"2:2",@"3:3",@"平其他",@"0:1",@"0:2",@"1:2",@"0:3",@"1:3",@"2:3",@"0:4",
                        @"1:4",@"2:4",@"0:5",@"1:5",@"2:5",@"负其他"];
    }
    return bfArray;
}

+ (NSArray *) getOddsJQSArray {
    if (jqsArray == NULL) {
        jqsArray = @[@"0球",@"1球",@"2球",@"3球",@"4球",@"5球",@"6球",@"7+球"];
    }
    
    return jqsArray;
}

+ (NSArray *)getOddsSubmitJQSArray {
    if (jqsSArray == NULL) {
        jqsSArray = @[@"0",@"1",@"2",@"3",@"4",@"5",@"6",@"7"];
    }
    
    return jqsSArray;
}


+ (NSArray *) getOddsBQCArray {
    if (bqcArray == NULL) {
        bqcArray = @[@"胜胜",@"胜平",@"胜负",@"平胜",@"平平",@"平负",@"负胜",@"负平",@"负负"];
    }
    
    return bqcArray;
}

+ (NSArray *) getOddsSubmitBQCArray {
    if (bqcSArray == NULL) {
        bqcSArray = @[@"胜-胜",@"胜-平",@"胜-负",@"平-胜",@"平-平",@"平-负",@"负-胜",@"负-平",@"负-负"];
    }
    
    return bqcSArray;
}

+ (NSInteger) getStrWeekInt:(NSString *)week {
    NSInteger weekI = 0;
    if([week isEqualToString:@"周一"]) {
        weekI = 1;
    }
    else if([week isEqualToString:@"周二"]) {
        weekI = 2;
    }
    else if([week isEqualToString:@"周三"]) {
        weekI = 3;
    }
    else if([week isEqualToString:@"周四"]) {
        weekI = 4;
    }
    else if([week isEqualToString:@"周五"]) {
        weekI = 5;
    }
    else if([week isEqualToString:@"周六"]) {
        weekI = 6;
    }
    else if([week isEqualToString:@"周日"]) {
        weekI = 7;
    }
    
    return weekI;
}

+ (NSString *)getGameingWayType:(OddsType)oddsType {
    switch (oddsType) {
        case Odds_BLEND:
            return @"ZQHH";
        case Odds_SPF:
            return @"SPF";
        case Odds_RQSPF:
            return @"RQSPF";
        case Odds_Score:
            return @"BF";
        case Odds_TotalGoal:
            return @"JQS";
        case Odds_DoubleResult:
            return @"BQC";
    }
}

+ (NSString *)getWayType:(OddsType)oddsType {
    switch (oddsType) {
        case Odds_BLEND:
            return @"ZQHH";
        case Odds_SPF:
            return @"SPF";
        case Odds_RQSPF:
            return @"RQSPF";
        case Odds_Score:
            return @"BF";
        case Odds_TotalGoal:
            return @"JQS";
        case Odds_DoubleResult:
            return @"BQC";
    }
}

@end
