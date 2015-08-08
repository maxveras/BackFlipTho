//
//  GameScore.m
//  ThatBackFlipTho
//
//  Created by Andrew Medvedev on 08.08.15.
//  Copyright (c) 2015 200GO. All rights reserved.
//

#import "GameScore.h"

static NSString* kOverallScore = @"OverallScore";
static NSString* kHighScore    = @"HighScore";

@implementation GameScore

//-----------------------------------------------------------------
- (instancetype)init
{
    self = [super init];
    if (self) {
        [self loadScore];
    }
    return self;
}

//-----------------------------------------------------------------
- (void)setCurrentScore:(NSInteger)currentScore {
    _currentScore = currentScore;
    _overallScore++;
}

//-----------------------------------------------------------------
- (void)saveOverallScore {
    NSUserDefaults* defaults = [NSUserDefaults standardUserDefaults];
    [defaults setObject:@(_overallScore) forKey:kOverallScore];
    [defaults setObject:@(_highScore) forKey:kHighScore];
    [defaults synchronize];
}

//-----------------------------------------------------------------
- (void)loadScore {
    NSUserDefaults* defaults = [NSUserDefaults standardUserDefaults];
    _overallScore = [[defaults objectForKey:kOverallScore]integerValue];
    _highScore    = [[defaults objectForKey:kHighScore]integerValue];
}

@end
