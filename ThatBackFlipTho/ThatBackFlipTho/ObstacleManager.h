//
//  ObstacleManager.h
//  ThatBackFlipTho
//
//  Created by Andrew Medvedev on 23.07.15.
//  Copyright (c) 2015 200GO. All rights reserved.
//

#import <SpriteKit/SpriteKit.h>
@class GameScene;

#define SCREEN_WIDTH ([[UIScreen mainScreen] bounds].size.width)
#define SCREEN_HEIGHT ([[UIScreen mainScreen] bounds].size.height)

@interface ObstacleManager : NSObject
+ (instancetype) getInstance;

- (void) update:(CFTimeInterval) currentTime;

//Данное значение регулирует частоту спаунов в пикселях
@property (assign, nonatomic) float obstacleDefaultRange;
@property (strong, nonatomic) GameScene* rootScene;

//Описание
//Функция определяет можно ли заспаунить новый обасткл. Проверяет положение последнего > чем obstacleDefaultRange
- (BOOL) canSpawnObstacle;


//Описание:
//Функция спаунит спрайт за экраном и заставляет его двигаться на перса
- (void) spawnObstacle:(SKSpriteNode*) obstacle;

//Описание:
//Функция проверяет вышел ли спрайт за границу экрана
- (BOOL) obstacleOutOfScreen:(SKSpriteNode*) obstacle;

//Описание:
//Функция возвращает последний спрайт
- (SKSpriteNode*) lastObstacle;

@end
