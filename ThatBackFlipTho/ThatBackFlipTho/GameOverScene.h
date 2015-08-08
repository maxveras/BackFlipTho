//
//  GameOverScene.h
//  ThatBackFlipTho
//
//  Created by Andrew Medvedev on 30.07.15.
//  Copyright (c) 2015 200GO. All rights reserved.
//

#import <SpriteKit/SpriteKit.h>

@interface SKScene(Unarchive)
+ (instancetype)unarchiveFromFile:(NSString *)file ;
@end

@interface GameOverScene : SKScene

//Проброс из другой сцены
@property(assign, nonatomic) NSInteger currentScore;
@property(assign, nonatomic) NSInteger overallScore;
@property(assign, nonatomic) NSInteger highScore;

@end
