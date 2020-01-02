//
//  LLOddsCalc.m
//  LLottery
//
//  Created by Sujiewen on 17/4/5.
//  Copyright © 2017年  Sjw. All rights reserved.
//

#import "LLOddsCalc.h"

@interface LLOddsCalc ()

@property (nonatomic) NSDictionary *caseDict;

@property (nonatomic) NSInteger minDan; //至少几胆
@property (nonatomic) NSInteger maxDan; //胆数
@property (nonatomic) CGFloat maxBonus;
@property (nonatomic) CGFloat minBonus;

@end

static LLOddsCalc *instanceOddsCalc;

@implementation LLOddsCalc

+ (LLOddsCalc *)sharedInstance {
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        if(instanceOddsCalc == NULL) {
            instanceOddsCalc = [[self alloc] init];
        }
    });
    
    return instanceOddsCalc;
}

+(instancetype)allocWithZone:(struct _NSZone *)zone {
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        if(instanceOddsCalc == NULL) {
            instanceOddsCalc = [super allocWithZone:zone];
        }
    });
    
    return instanceOddsCalc;
}

-(id)copyWithZone:(NSZone *)zone {
    return instanceOddsCalc;
}

- (instancetype)init
{
    self = [super init];
    if (self) {
        _caseDict = @{@"1串1": @(1),
                      @"2串1": @(2),
                      @"3串1": @(3), @"3串3": @(4), @"3串4": @(5),
                      @"4串1": @(6), @"4串4": @(7), @"4串5": @(8), @"4串6": @(9), @"4串11": @(10),
                      @"5串1": @(11), @"5串5": @(12), @"5串6": @(13), @"5串10": @(14), @"5串16": @(15), @"5串20": @(16), @"5串26": @(17),
                      @"6串1": @(18), @"6串6": @(19), @"6串7": @(20), @"6串15": @(21), @"6串20": @(22), @"6串22": @(23), @"6串35": @(24), @"6串42": @(25), @"6串50": @(26), @"6串57": @(27),
                      @"7串1": @(28), @"7串7": @(29), @"7串8": @(30), @"7串21": @(31), @"7串35": @(32), @"7串120":@(33),
                      @"8串1": @(34), @"8串8": @(35), @"8串9": @(36), @"8串28": @(37), @"8串56": @(38), @"8串70": @(39), @"8串247": @(40)
                      };
    }
    return self;
}
- (void)calcValue {
    
}

- (CGFloat)myCalc:(NSString *)passType Dan:(NSArray *)danArray Tuo:(NSArray*)touArray {
    
    if (danArray == NULL || [danArray count] == 0)
        return [self calc:passType Dan:danArray Tuo:touArray];
    else {
        CGFloat wcount = 0;
        for (NSInteger i = _minDan; i <= _maxDan; i++) {
            NSArray *bm = [self comp:danArray Len:i];
            for (NSInteger j = 0; j > [bm count]; j++) {
                wcount += [self calc:passType Dan:bm[j] Tuo:touArray];
            }
        }
        return wcount;
    }
}

- (CGFloat)calc:(NSString *)passType Dan:(NSArray *)danArray Tuo:(NSArray*)touArray {
    CGFloat wagerCount = 0;
    NSArray *array = [passType split:@"串"];
    NSInteger pc = [array[0] integerValue];
    NSInteger absCount = [danArray count]; //胆场
    NSInteger len = pc - absCount;
    if (len == 0 && absCount > 0) {
        NSMutableArray *pm = [[NSMutableArray alloc] initWithCapacity:pc];
        for (id p in danArray) {
            for (NSInteger k = 0; k < pc; k++) {
                if (pm[k] == 0 || pm[k] == nil) {
                    pm[k] = p;
                    break;
                }
            }
        }
        
//         NSString *pstr = @"";
         for (NSInteger ii = 0; ii < [pm count]; ii++) {
             if(ii % 7 == 0) {
                 
             }
             else {
                 
             }
        }
//        NSString pstr = pm.slice(0, pc).join(",");
//        if (pstr.substr(pstr.length - 1) == ",")
//            return;
    }
    else {
        NSMutableArray *arr = [[NSMutableArray alloc] init];
        for (NSInteger i = 0; i < [touArray count]; i++) { //sa=[4,5,6] sb=[1,2,3]
            [arr addObject:@(i)];  //拖
        }
        NSArray *w = [self comp:arr Len:len]; //拖场组合 [4,5],[4,6],[5,6]
        for (NSInteger i = 0; i < [w count]; i++) {
            NSArray *splitArr = w[i];
            NSMutableArray *pm = [[NSMutableArray alloc] initWithCapacity:pc];
            for (NSInteger k = 0; k < pc; k++) {
                id d = splitArr[k];

                pm[k] = splitArr[k] != NULL ? touArray[[d integerValue]] : 0;
            }
            if (absCount > 0) {
                for (NSInteger p =0; p < [danArray count]; p++) {
                    id AbsVoteC = danArray[p];
                    for (NSInteger k = 0; k < pc; k++) {
                        if (pm[k] == 0 || pm[k] == NULL) {
                            pm[k] = AbsVoteC;
                            break;
                        }
                    }
                }
            }
            
            NSMutableArray *tmpPM = [[NSMutableArray alloc] init];
            NSInteger x = 0;
            while ( x < pc) {
                [tmpPM addObject:pm[x]];
                x++;
            }
            
            wagerCount += [self calcuteWC:passType Array:tmpPM];
        }
    }
    
    return wagerCount;
}

- (CGFloat)calcuteWC:(NSString *)passType Array:(NSArray *)dataArray {
    CGFloat result = 0;
    CGFloat a = ([dataArray count] < 1  ? 0 : [dataArray[0] floatValue]);
    CGFloat b = ([dataArray count] < 2  ? 0 : [dataArray[1] floatValue]);
    CGFloat c = ([dataArray count] < 3  ? 0 : [dataArray[2] floatValue]);
    CGFloat d = ([dataArray count] < 4  ? 0 : [dataArray[3] floatValue]);
    CGFloat e = ([dataArray count] < 5  ? 0 : [dataArray[4] floatValue]);
    CGFloat f = ([dataArray count] < 6  ? 0 : [dataArray[5] floatValue]);
    CGFloat g = ([dataArray count] < 7  ? 0 : [dataArray[6] floatValue]);
    CGFloat h = ([dataArray count] < 8  ? 0 : [dataArray[7] floatValue]);
//    CGFloat i = ([dataArray count] < 9  ? 0 : [dataArray[8] floatValue]);
//    CGFloat j = ([dataArray count] < 10  ? 0 : [dataArray[9] floatValue]);
//    CGFloat k = ([dataArray count] < 11  ? 0 : [dataArray[10] floatValue]);
//    CGFloat l = ([dataArray count] < 12  ? 0 : [dataArray[11] floatValue]);
//    CGFloat m = ([dataArray count] < 13  ? 0 : [dataArray[12] floatValue]);
//    CGFloat n = ([dataArray count] < 14  ? 0 : [dataArray[13] floatValue]);
//    CGFloat o = ([dataArray count] < 15  ? 0 : [dataArray[14] floatValue]);
    
    NSInteger v = [_caseDict[passType] integerValue];
    switch (v) {
        case 1:
            result = a;
            break;
        case 2:
            result = a * b;
            break;
        case 3:
            result = a * b * c;
            break;
        case 4:
            result =a * b + a * c + b * c;
            break;
        case 5:
            result = a * b * c + a * b + a * c + b * c;
            break;
        case 6:
            result =a * b * c * d;
            break;
        case 7:
            result =a * b * c + a * b * d + a * c * d + b * c * d;
            break;
        case 8:
            result =(a + 1) * (b + 1) * (c + 1) * (d + 1) - (a * (b + c + d + 1) + b * (c + d + 1) + (c + 1) * (d + 1));
            break;
        case 9:
            result =a * b + a * c + a * d + b * c + b * d + c * d;
            break;
        case 10:
            result =(a + 1) * (b + 1) * (c + 1) * (d + 1) - (a + b + c + d + 1);
            break;
        case 11:
            result =a * b * c * d * e;
            break;
        case 12:
            result =a * b * c * d + a * b * c * e + a * b * d * e + a * c * d * e + b * c * d * e;
            break;
        case 13:
            result =a * b * c * d * e + a * b * c * d + a * b * c * e + a * b * d * e + a * c * d * e + b * c * d * e;
            break;
        case 14:
            result =a * b + a * c + a * d + a * e + b * c + b * d + b * e + c * d + c * e + d * e;
            break;
        case 15:
            result =(a + 1) * (b + 1) * (c + 1) * (d + 1) * (e + 1) - (a * (b + c + d + e + 1) + b * (c + d + e + 1) + c * (d + e + 1) + (d + 1) * (e + 1));
            break;
        case 16:
            result =a * b * c + a * b * d + a * b * e + a * c * d + a * c * e + a * d * e + b * c * d + b * c * e + b * d * e + c * d * e
            + a * b + a * c + a * d + a * e + b * c + b * d + b * e + c * d + c * e + d * e;
            break;
        case 17:
            result =(a + 1) * (b + 1) * (c + 1) * (d + 1) * (e + 1) - (a + b + c + d + e + 1);
            break;
        case 18:
            result =a * b * c * d * e * f;
            break;
        case 19:
            result =a * b * c * d * e + a * b * c * d * f + a * b * c * e * f + a * b * d * e * f + a * c * d * e * f + b * c * d * e * f;
            break;
        case 20:
            result =a * b * c * d * e * f + a * b * c * d * e + a * b * c * d * f + a * b * c * e * f + a * b * d * e * f + a * c * d * e * f + b * c * d * e * f;
            break;
        case 21:
            result =a * b + a * c + a * d + a * e + a * f + b * c + b * d + b * e + b * f + c * d + c * e + c * f + d * e + d * f + e * f;
            break;
        case 22:
            result =a * b * c + a * b * d + a * b * e + a * b * f + a * c * d + a * c * e + a * c * f + a * d * e + a * d * f + a * e * f + b * c * d + b * c * e + b * c * f + b * d * e + b * d * f + b * e * f + c * d * e + c * d * f + c * e * f + d * e * f;
            break;
        case 23:
            result =a * b * c * d * e * f + a * b * c * d * e + a * b * c * d * f + a * b * c * e * f + a * b * d * e * f + a * c * d * e * f + b * c * d * e * f
            + a * b * c * d + a * b * c * e + a * b * c * f + a * b * d * e + a * b * d * f + a * b * e * f + a * c * d * e + a * c * d * f + a * c * e * f + a * d * e * f
            + b * c * d * e + b * c * d * f + b * c * e * f + b * d * e * f + c * d * e * f;
            break;
        case 24:
            result =a * b * c + a * b * d + a * b * e + a * b * f + a * c * d + a * c * e + a * c * f + a * d * e + a * d * f + a * e * f + b * c * d + b * c * e + b * c * f + b * d * e + b * d * f + b * e * f + c * d * e + c * d * f + c * e * f + d * e * f + a * b + a * c + a * d + a * e + a * f + b * c + b * d + b * e + b * f + c * d + c * e + c * f + d * e + d * f + e * f;
            break;
        case 25:
            result =(a + 1) * (b + 1) * (c + 1) * (d + 1) * (e + 1) * (f + 1) - (a * (b + c + d + e + f + 1) + b * (c + d + e + f + 1) + c * (d + e + f + 1) + d * (e + f + 1) + (e + 1) * (f + 1));
            break;
        case 26:
            result =(a + 1) * (b + 1) * (c + 1) * (d + 1) * (e + 1) * (f + 1) - (a + b + c + d + e + f + 1) - (a * b * c * d * e + a * b * c * d * f + a * b * c * e * f + a * b * d * e * f + a * c * d * e * f + b * c * d * e * f + a * b * c * d * e * f);
            break;
        case 27:
            result =(a + 1) * (b + 1) * (c + 1) * (d + 1) * (e + 1) * (f + 1) - (a + b + c + d + e + f + 1);
            break;
        case 28:
            result =a * b * c * d * e * f * g;
            break;
        case 29:
            result =a * b * c * d * e * f + a * b * c * d * e * g + a * b * c * d * f * g + a * b * c * e * f * g + a * b * d * e * f * g + a * c * d * e * f * g + b * c * d * e * f * g;
            break;
        case 30:
            result =a * b * c * d * e * f * g + a * b * c * d * e * f + a * b * c * d * e * g + a * b * c * d * f * g + a * b * c * e * f * g + a * b * d * e * f * g + a * c * d * e * f * g + b * c * d * e * f * g;
            break;
        case 31:
            result =a * b * c * d * e + a * b * c * d * f + a * b * c * d * g + a * b * c * e * f
            + a * b * c * e * g + a * b * c * f * g + a * b * d * e * f + a * b * d * e * g
            + a * b * d * f * g + a * b * e * f * g + a * c * d * e * f + a * c * d * e * g
            + a * c * d * f * g + a * c * e * f * g + a * d * e * f * g + b * c * d * e * f
            + b * c * d * e * g + b * c * d * f * g + b * c * e * f * g + b * d * e * f * g
            + c * d * e * f * g;
            break;
        case 32:
            result =a * b * c * d + a * b * c * e + a * b * c * f + a * b * c * g + a * b * d * e + a * b * d * f
            + a * b * d * g + a * b * e * f + a * b * e * g + a * b * f * g + a * c * d * e + a * c * d * f
            + a * c * d * g + a * c * e * f + a * c * e * g + a * c * f * g + a * d * e * f + a * d * e * g
            + a * d * f * g + a * e * f * g + b * c * d * e + b * c * d * f + b * c * d * g + b * c * e * f
            + b * c * e * g + b * c * f * g + b * d * e * f + b * d * e * g + b * d * f * g + b * e * f * g
            + c * d * e * f + c * d * e * g + c * d * f * g + c * e * f * g + d * e * f * g;
            break;
        case 33:
            result =(a + 1) * (b + 1) * (c + 1) * (d + 1) * (e + 1) * (f + 1) * (g + 1) - (a + b + c + d + e + f + g + 1);
            break;
        case 34:
            result =a * b * c * d * e * f * g * h;
            break;
        case 35:
            result =a * b * c * d * e * f * g + a * b * c * d * e * f * h + a * b * c * d * e * g * h
            + a * b * c * d * f * g * h + a * b * c * e * f * g * h + a * b * d * e * f * g * h
            + a * c * d * e * f * g * h + b * c * d * e * f * g * h;
            break;
        case 36:
            result =a * b * c * d * e * f * g * h + a * b * c * d * e * f * g + a * b * c * d * e * f * h
            + a * b * c * d * e * g * h + a * b * c * d * f * g * h + a * b * c * e * f * g * h
            + a * b * d * e * f * g * h + a * c * d * e * f * g * h + b * c * d * e * f * g * h;
            break;
        case 37:
            result =a * b * c * d * e * f + a * b * c * d * e * g + a * b * c * d * e * h + a * b * c * d * f * g
            + a * b * c * d * f * h + a * b * c * d * g * h + a * b * c * e * f * g + a * b * c * e * f * h
            + a * b * c * e * g * h + a * b * c * f * g * h + a * b * d * e * f * g + a * b * d * e * f * h
            + a * b * d * e * g * h + a * b * d * f * g * h + a * b * e * f * g * h + a * c * d * e * f * g
            + a * c * d * e * f * h + a * c * d * e * g * h + a * c * d * f * g * h + a * c * e * f * g * h
            + a * d * e * f * g * h + b * c * d * e * f * g + b * c * d * e * f * h + b * c * d * e * g * h
            + b * c * d * f * g * h + b * c * e * f * g * h + b * d * e * f * g * h + c * d * e * f * g * h;
            break;
        case 38:
            result =a * b * c * d * e + a * b * c * d * f + a * b * c * d * g + a * b * c * d * h + a * b * c * e * f
            + a * b * c * e * g + a * b * c * e * h + a * b * c * f * g + a * b * c * f * h + a * b * c * g * h
            + a * b * d * e * f + a * b * d * e * g + a * b * d * e * h + a * b * d * f * g + a * b * d * f * h
            + a * b * d * g * h + a * b * e * f * g + a * b * e * f * h + a * b * e * g * h + a * b * f * g * h
            + a * c * d * e * f + a * c * d * e * g + a * c * d * e * h + a * c * d * f * g + a * c * d * f * h
            + a * c * d * g * h + a * c * e * f * g + a * c * e * f * h + a * c * e * g * h + a * c * f * g * h
            + a * d * e * f * g + a * d * e * f * h + a * d * e * g * h + a * d * f * g * h + a * e * f * g * h
            + b * c * d * e * f + b * c * d * e * g + b * c * d * e * h + b * c * d * f * g + b * c * d * f * h
            + b * c * d * g * h + b * c * e * f * g + b * c * e * f * h + b * c * e * g * h + b * c * f * g * h
            + b * d * e * f * g + b * d * e * f * h + b * d * e * g * h + b * d * f * g * h + b * e * f * g * h
            + c * d * e * f * g + c * d * e * f * h + c * d * e * g * h + c * d * f * g * h + c * e * f * g * h
            + d * e * f * g * h;
            break;
        case 39:
            result =a * b * c * d + a * b * c * e + a * b * c * f + a * b * c * g + a * b * c * h + a * b * d * e
            + a * b * d * f + a * b * d * g + a * b * d * h + a * b * e * f + a * b * e * g + a * b * e * h
            + a * b * f * g + a * b * f * h + a * b * g * h + a * c * d * e + a * c * d * f + a * c * d * g
            + a * c * d * h + a * c * e * f + a * c * e * g + a * c * e * h + a * c * f * g + a * c * f * h
            + a * c * g * h + a * d * e * f + a * d * e * g + a * d * e * h + a * d * f * g + a * d * f * h
            + a * d * g * h + a * e * f * g + a * e * f * h + a * e * g * h + a * f * g * h + b * c * d * e
            + b * c * d * f + b * c * d * g + b * c * d * h + b * c * e * f + b * c * e * g + b * c * e * h
            + b * c * f * g + b * c * f * h + b * c * g * h + b * d * e * f + b * d * e * g + b * d * e * h
            + b * d * f * g + b * d * f * h + b * d * g * h + b * e * f * g + b * e * f * h + b * e * g * h
            + b * f * g * h + c * d * e * f + c * d * e * g + c * d * e * h + c * d * f * g + c * d * f * h
            + c * d * g * h + c * e * f * g + c * e * f * h + c * e * g * h + c * f * g * h + d * e * f * g
            + d * e * f * h + d * e * g * h + d * f * g * h + e * f * g * h;
            break;
        case 40:
            result = (a + 1) * (b + 1) * (c + 1) * (d + 1) * (e + 1) * (f + 1) * (g + 1) * (h + 1) - (a + b + c + d + e + f + g + h + 1);
            break;
    }
    return result;
}

- (NSMutableArray *)comp:(NSArray *)danArray Len:(NSInteger)len {
    NSMutableArray *array = [[NSMutableArray alloc] initWithCapacity:[danArray count]];
    
    NSComparator numberCmptr = ^(id obj1, id obj2){
        if ([obj1 integerValue] > [obj2 integerValue]) {
            return (NSComparisonResult)NSOrderedDescending;
        }
        
        if ([obj1 integerValue] < [obj2 integerValue]) {
            return (NSComparisonResult)NSOrderedAscending;
        }
        return (NSComparisonResult)NSOrderedSame;
    };
    
    
    NSMutableArray *tmpDanAray = [[NSMutableArray alloc] initWithArray:[danArray sortedArrayUsingComparator:numberCmptr]];
    
    if ([tmpDanAray count] < len || len < 1) {
        return array;
    } else if ([tmpDanAray count] == len) {
        [array addObject:tmpDanAray];
        return array;
    }
    if (len == 1) {
        for (NSInteger i =0; i < [tmpDanAray count]; i++) {
            NSMutableArray *tmpA = [[NSMutableArray alloc] initWithCapacity:1];
            array[i] = tmpA;
            [tmpA addObject:tmpDanAray[i]];
        }
        return array;
    }
    if (len > 1) {
        for (NSInteger i =0; i < [tmpDanAray count]; i++) {
            NSMutableArray *arr_b = [[NSMutableArray alloc] init];
            for (NSInteger j =0; j < [tmpDanAray count]; j++) {
                if (j > i)
                    [arr_b addObject:tmpDanAray[j]];
            }
            NSMutableArray *s = [self comp:arr_b Len:len-1];
            if ([s count] > 0) {
                for (NSInteger k =0; k < [s count]; k++) {
                    NSMutableArray *p = s[k];
                    [p addObject:tmpDanAray[i]];
                    [p setArray:[p sortedArrayUsingComparator:numberCmptr]];
                    [array addObject:p];
                }
            }
        }
    }

    return array;
}

@end
