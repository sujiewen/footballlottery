//
//  LLOddsCalc.h
//  LLottery
//
//  Created by Sujiewen on 17/4/5.
//  Copyright © 2017年  Sjw. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface LLOddsCalc : NSObject

+ (LLOddsCalc *)sharedInstance;

- (CGFloat)myCalc:(NSString *)passType Dan:(NSArray *)danArray Tuo:(NSArray*)touArray;

- (void)calcValue;

@end
