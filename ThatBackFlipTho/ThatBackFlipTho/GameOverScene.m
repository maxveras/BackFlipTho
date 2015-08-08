//
//  GameOverScene.m
//  ThatBackFlipTho
//
//  Created by Andrew Medvedev on 30.07.15.
//  Copyright (c) 2015 200GO. All rights reserved.
//

#import "GameOverScene.h"
#import "GameScene.h"
#import "GameScore.h"

@implementation SKScene (Unarchive)

+ (instancetype)unarchiveFromFile:(NSString *)file {
    NSString *nodePath = [[NSBundle mainBundle] pathForResource:file ofType:@"sks"];
    /* Unarchive the file to an SKScene object */
    NSData *data = [NSData dataWithContentsOfFile:nodePath
                                          options:NSDataReadingMappedIfSafe
                                            error:nil];
    NSKeyedUnarchiver *arch = [[NSKeyedUnarchiver alloc] initForReadingWithData:data];
    [arch setClass:self forClassName:@"SKScene"];
    SKScene *scene = [arch decodeObjectForKey:NSKeyedArchiveRootObjectKey];
    [arch finishDecoding];
    
    return scene;
}
@end

@implementation GameOverScene

- (void)didMoveToView:(SKView *)view {
    SKLabelNode* overallScore = (SKLabelNode*)[self.scene childNodeWithName:@"overallScore"];
    SKLabelNode* currentScore = (SKLabelNode*)[self.scene childNodeWithName:@"currentScore"];
    SKLabelNode* hightScore   = (SKLabelNode*)[self.scene childNodeWithName:@"hightScore"];
    overallScore.text = [NSString stringWithFormat:@"Overall score: %ld", (long)_overallScore];
    currentScore.text = [NSString stringWithFormat:@"Score %ld", (long)_currentScore];
    hightScore.text   = [NSString stringWithFormat:@"High score %ld", (long)_highScore];
}

//-----------------------------------------------------------------
- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event {
    GameScene* gameScene = [GameScene unarchiveFromFile:@"GameScene"];    
    SKTransition* transition = [SKTransition doorsCloseHorizontalWithDuration:0.1];
    [self.view presentScene:gameScene transition:transition];
}

@end
