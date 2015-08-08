//
//  GameScore.h
//  ThatBackFlipTho
//
//  Created by Andrew Medvedev on 08.08.15.
//  Copyright (c) 2015 200GO. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface GameScore : NSObject

@property(assign, nonatomic) NSInteger currentScore;
@property(assign, nonatomic) NSInteger overallScore;
@property(assign, nonatomic) NSInteger highScore;


- (void)saveOverallScore;
@end
