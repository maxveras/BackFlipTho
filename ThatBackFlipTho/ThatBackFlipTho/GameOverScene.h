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
@end
