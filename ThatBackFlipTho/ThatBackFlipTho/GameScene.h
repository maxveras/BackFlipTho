//
//  GameScene.h
//  ThatBackFlipTho
//

//  Copyright (c) 2015 200GO. All rights reserved.
//

#import <SpriteKit/SpriteKit.h>

//Перечисление типов объектов, с которыми можем столкнуться
//Другими словами колайдер для каждого типа объекта
typedef enum {
    ColliderTypeActor,
    ColliderTypeGround,
    COlliderTypeBorder
} ColliderType;


@interface GameScene : SKScene <SKPhysicsContactDelegate>


//Группа элементов земли
@property (nonatomic, strong) SKNode* ground_01;
@property (nonatomic, strong) SKNode* ground_02;

//Темносиний слой фона города
@property (nonatomic, strong) SKSpriteNode* cityFarBackgroundFirst_01;
@property (nonatomic, strong) SKSpriteNode* cityFarBackgroundFirst_02;

//Светлосиний слой фона города
@property (nonatomic, strong) SKSpriteNode* cityFarBackgroundSecond_01;
@property (nonatomic, strong) SKSpriteNode* cityFarBackgroundSecond_02;

//Дальний слой города
@property (nonatomic, strong) SKNode* cityBackgroundThird_01;
@property (nonatomic, strong) SKNode* cityBackgroundThird_02;

//Средний слой города
@property (nonatomic, strong) SKNode* cityBackgroundSecond_01;
@property (nonatomic, strong) SKNode* cityBackgroundSecond_02;

//ближний слой города
@property (nonatomic, strong) SKNode* cityBackgroundFirst_01;
@property (nonatomic, strong) SKNode* cityBackgroundFirst_02;


@property (nonatomic, assign) CGFloat groundHeight;

//Bach
@property (nonatomic, strong) SKNode* bach;
@property (nonatomic, strong) NSArray* runAnimation;

@end
