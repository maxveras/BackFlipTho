//
//  GameScene.m
//  ThatBackFlipTho
//
//  Created by Максим on 03.07.15.
//  Copyright (c) 2015 200GO. All rights reserved.
//

#import "GameScene.h"

static NSString* kActionRunAnimation = @"RunAnimation";
static NSString* kActionRunAnimationLoop = @"RunAnimationLoop";


@interface GameScene()
@property (nonatomic, assign) BOOL onAir;
@property (nonatomic, assign) CGFloat impuls;
@property (nonatomic, strong) SKAction* runAction;
@end

@implementation GameScene

static CGFloat defaultGameSpeed = 40;

//---------------------------------------------------------------
-(void)didMoveToView:(SKView *)view {
    self.onAir = NO;
    self.physicsWorld.contactDelegate = self;
    
    [self prepareGroundToMove];
    [self prepareCityToMove];
    [self prepareCityPositionAndScale];
    
    _groundHeight = _ground_01.frame.size.height;
    
    [self initActor];
}

//---------------------------------------------------------------
-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event {
    if(self.onAir == NO) {
        self.onAir = YES;
        self.impuls = 10;
        [self.bach removeActionForKey:kActionRunAnimationLoop];
        //TODO: Stop run animation
    }
}

//---------------------------------------------------------------
- (void)didBeginContact:(SKPhysicsContact *)contact {
    if(self.onAir == YES) {
        self.onAir = NO;
        self.impuls = 0;
        if(self.runAction)
            [self.bach runAction:self.runAction withKey:kActionRunAnimationLoop];
    }
}

//---------------------------------------------------------------
- (void) initActor {
    _bach = [self childNodeWithName:@"bach"];
   // _bach.physicsBody = [SKPhysicsBody bodyWithRectangleOfSize:[[SKTexture textureWithImageNamed:@"kingBach1"] size]];
    if(!_bach.physicsBody)
        NSLog(@"Bach phys body do not inited");
    
    self.bach.physicsBody.contactTestBitMask = ColliderTypeGround | COlliderTypeBorder;
    self.bach.physicsBody.collisionBitMask = ColliderTypeGround | COlliderTypeBorder;
    self.bach.physicsBody.categoryBitMask = ColliderTypeActor;
    
    
    [_bach setScale:0.35f];
    [_bach setPosition:CGPointMake(400, _groundHeight +100)];
    
    SKTextureAtlas* atlas = [SKTextureAtlas atlasNamed:@"RunBach"];
    NSMutableArray* tempAnimations = [NSMutableArray new];
    for(int i = 1; i <= atlas.textureNames.count; i++) {
        SKTexture* texture = [atlas textureNamed:[NSString stringWithFormat:@"kingBach%d",i]];
        [tempAnimations addObject:texture];
    }
    _runAnimation = [NSArray arrayWithArray:tempAnimations];
    
    SKAction* playBachAnim = [SKAction animateWithTextures:tempAnimations timePerFrame:0.15];
    self.runAction = [SKAction repeatActionForever:playBachAnim];
    [_bach runAction:self.runAction withKey:kActionRunAnimationLoop];
}

//---------------------------------------------------------------
- (BOOL) checkOutFromScreen:(SKNode*) sprite {
    CGFloat offset = sprite.position.x;
    if(offset < -sprite.frame.size.width/2 + 2) {
        return YES;
    }
    return NO;
}

//---------------------------------------------------------------
-(void)update:(CFTimeInterval)currentTime {
    [self updatePlayer:currentTime];
    //Проверяем вышла ли земля за границы экрана а затем перекидываем е> вначало очереди на показ
    if([self checkOutFromScreen:_ground_01] == YES) {
        _ground_01.position = CGPointMake(_ground_02.position.x + _ground_02.frame.size.width, _ground_01.position.y);
    }
    if([self checkOutFromScreen:_ground_02] == YES) {
        _ground_02.position = CGPointMake(_ground_01.position.x + _ground_01.frame.size.width, _ground_02.position.y);
    }
    
    ////////////////////////////////////////////////////////////////////////
    if([self checkOutFromScreen:_cityBackgroundFirst_01] == YES) {
        _cityBackgroundFirst_01.position = CGPointMake(_cityBackgroundFirst_02.position.x + _cityBackgroundFirst_02.frame.size.width, _cityBackgroundFirst_01.position.y);
    }
    if([self checkOutFromScreen:_cityBackgroundFirst_02] == YES) {
        _cityBackgroundFirst_02.position = CGPointMake(_cityBackgroundFirst_01.position.x + _cityBackgroundFirst_01.frame.size.width, _cityBackgroundFirst_02.position.y);
    }
    
    ////////////////////////////////////////////////////////////////////////
    if([self checkOutFromScreen:_cityBackgroundSecond_01] == YES) {
        _cityBackgroundSecond_01.position = CGPointMake(_cityBackgroundSecond_02.position.x + _cityBackgroundSecond_02.frame.size.width, _cityBackgroundSecond_01.position.y);
    }
    if([self checkOutFromScreen:_cityBackgroundSecond_02] == YES) {
        _cityBackgroundSecond_02.position = CGPointMake(_cityBackgroundSecond_01.position.x + _cityBackgroundSecond_01.frame.size.width, _cityBackgroundSecond_02.position.y);
    }
    
    
    ////////////////////////////////////////////////////////////////////////
    if([self checkOutFromScreen:_cityBackgroundThird_01] == YES) {
        _cityBackgroundThird_01.position = CGPointMake(_cityBackgroundThird_02.position.x + _cityBackgroundThird_02.frame.size.width, _cityBackgroundThird_01.position.y);
    }
    if([self checkOutFromScreen:_cityBackgroundThird_02] == YES) {
        _cityBackgroundThird_02.position = CGPointMake(_cityBackgroundThird_01.position.x + _cityBackgroundThird_01.frame.size.width, _cityBackgroundThird_02.position.y);
    }
    
    ////////////////////////////////////////////////////////////////////////
    if([self checkOutFromScreen:_cityFarBackgroundFirst_01] == YES) {
        _cityFarBackgroundFirst_01.position = CGPointMake(_cityFarBackgroundFirst_02.position.x + _cityFarBackgroundFirst_02.frame.size.width, _cityFarBackgroundFirst_01.position.y);
    }
    if([self checkOutFromScreen:_cityFarBackgroundFirst_02] == YES) {
        _cityFarBackgroundFirst_02.position = CGPointMake(_cityFarBackgroundFirst_01.position.x + _cityFarBackgroundFirst_01.frame.size.width, _cityFarBackgroundFirst_02.position.y);
    }
    
    ////////////////////////////////////////////////////////////////////////
    if([self checkOutFromScreen:_cityFarBackgroundSecond_01] == YES) {
        _cityFarBackgroundSecond_01.position = CGPointMake(_cityBackgroundThird_02.position.x + _cityBackgroundThird_02.frame.size.width, _cityFarBackgroundSecond_01.position.y);
    }
    if([self checkOutFromScreen:_cityFarBackgroundSecond_02] == YES) {
        _cityFarBackgroundSecond_02.position = CGPointMake(_cityFarBackgroundSecond_01.position.x + _cityFarBackgroundSecond_02.frame.size.width, _cityFarBackgroundSecond_02.position.y);
    }
    
}

//---------------------------------------------------------------
- (void) updatePlayer:(CFTimeInterval)currTime {
    if(self.onAir == YES) {
        CGFloat currentY = self.bach.position.y;
        CGPoint newPositionAddedByImpuls = CGPointMake(self.bach.position.x, currentY + self.impuls);
        self.bach.position = newPositionAddedByImpuls;
        self.impuls -= 0.098;//self.physicsWorld.gravity.dx;
    }
}

//---------------------------------------------------------------
//Описание:
//Функция подготавливает элементы земли к бесконечному перемещению
- (void) prepareGroundToMove {
    self.ground_01 = [self childNodeWithName:@"ground_01"];
    self.ground_02 = [self childNodeWithName:@"ground_02"];
    SKAction* moveGround01Sprite = [SKAction moveByX:-_ground_01.frame.size.width * defaultGameSpeed y:0 duration:0.1 * _ground_01.frame.size.width * 2];
    SKAction* moveGround02Sprite = [SKAction moveByX:-_ground_02.frame.size.width * defaultGameSpeed y:0 duration:0.1 * _ground_02.frame.size.width * 2];
    
    [_ground_01 runAction:moveGround01Sprite];
    [_ground_02 runAction:moveGround02Sprite];
}

//---------------------------------------------------------------
- (void) prepareCityToMove {
    //Make a sorite nodes
    self.cityBackgroundFirst_01 = [SKSpriteNode spriteNodeWithTexture:[SKTexture textureWithImageNamed:@"city_first_layer.png"]];
    self.cityBackgroundFirst_02 = [SKSpriteNode spriteNodeWithTexture:[SKTexture textureWithImageNamed:@"city_first_layer.png"]];
    
    self.cityBackgroundSecond_01 = [SKSpriteNode spriteNodeWithImageNamed:@"city_second_layer"];
    self.cityBackgroundSecond_02 = [SKSpriteNode spriteNodeWithImageNamed:@"city_second_layer"];
    
    self.cityBackgroundThird_01 = [SKSpriteNode spriteNodeWithImageNamed:@"city_tred_layer"];
    self.cityBackgroundThird_02 = [SKSpriteNode spriteNodeWithImageNamed:@"city_tred_layer"];
    
    self.cityFarBackgroundFirst_01 = [SKSpriteNode spriteNodeWithImageNamed:@"city_bacground_first_layer"];
    self.cityFarBackgroundFirst_02 = [SKSpriteNode spriteNodeWithImageNamed:@"city_bacground_first_layer"];

    self.cityFarBackgroundSecond_01 = [SKSpriteNode spriteNodeWithImageNamed:@"city_bacground_second_layer"];
    self.cityFarBackgroundSecond_02 = [SKSpriteNode spriteNodeWithImageNamed:@"city_bacground_second_layer"];
    
    //Create a sprite actions
    SKAction* moveCityFirst_01 = [SKAction moveByX:-self.cityBackgroundFirst_01.frame.size.width * defaultGameSpeed y:0 duration:0.1 * self.cityBackgroundFirst_01.frame.size.width * 2];
    SKAction* moveCityFirst_02 = [SKAction moveByX:-self.cityBackgroundFirst_02.frame.size.width * defaultGameSpeed y:0 duration:0.1 * self.cityBackgroundFirst_02.frame.size.width * 2];
    
    SKAction* moveCitySecond_01 = [SKAction moveByX:-self.cityBackgroundSecond_01.frame.size.width * 35 y:0 duration:0.1 * self.cityBackgroundSecond_01.frame.size.width * 2];
    SKAction* moveCitySecond_02 = [SKAction moveByX:-self.cityBackgroundSecond_02.frame.size.width * 35 y:0 duration:0.1 * self.cityBackgroundSecond_02.frame.size.width * 2];
    
    SKAction* moveCityThrid_01 = [SKAction moveByX:-self.cityBackgroundThird_01 .frame.size.width * 15 y:0 duration:0.1 * self.cityBackgroundThird_01 .frame.size.width * 2];
    SKAction* moveCityThrid_02 = [SKAction moveByX:-self.cityBackgroundThird_02.frame.size.width * 15 y:0 duration:0.1 * self.cityBackgroundThird_02.frame.size.width * 2];
    
    SKAction* moveFarCityFirst_01 = [SKAction moveByX:-self.cityFarBackgroundFirst_01.frame.size.width * 10 y:0 duration:0.1 * self.cityFarBackgroundFirst_01.frame.size.width * 2];
    SKAction* moveFarCityFirst_02 = [SKAction moveByX:-self.cityFarBackgroundFirst_02.frame.size.width * 10 y:0 duration:0.1 * self.cityFarBackgroundFirst_02.frame.size.width * 2];

    SKAction* moveFarCitySecond_01 = [SKAction moveByX:-self.cityFarBackgroundSecond_01.frame.size.width * 5 y:0 duration:0.1 * self.cityFarBackgroundSecond_01.frame.size.width * 2];
    SKAction* moveFarCitySecond_02 = [SKAction moveByX:-self.cityFarBackgroundSecond_02.frame.size.width * 5 y:0 duration:0.1 * self.cityFarBackgroundSecond_02.frame.size.width * 2];

    
    //Run actions
    [self.cityBackgroundFirst_01 runAction:moveCityFirst_01];
    [self.cityBackgroundFirst_02 runAction:moveCityFirst_02];
    
    [self.cityBackgroundSecond_01 runAction:moveCitySecond_01];
    [self.cityBackgroundSecond_02 runAction:moveCitySecond_02];
    
    [self.cityBackgroundThird_01 runAction:moveCityThrid_01];
    [self.cityBackgroundThird_02 runAction:moveCityThrid_02];
    
    [self.cityFarBackgroundFirst_01 runAction:moveFarCityFirst_01];
    [self.cityFarBackgroundFirst_02 runAction:moveFarCityFirst_02];
    
    [self.cityFarBackgroundSecond_01 runAction:moveFarCitySecond_01];
    [self.cityFarBackgroundSecond_02 runAction:moveFarCitySecond_02];
}

//----------------------------------------------------
-(void) prepareCityPositionAndScale {
    //Assign initial position
    [_cityBackgroundFirst_01 setScale:0.5];
    [_cityBackgroundFirst_02 setScale:0.5];
    
    [_cityBackgroundSecond_01 setScale:0.5];
    [_cityBackgroundSecond_02 setScale:0.5];
    
    [_cityBackgroundThird_01 setScale:0.5];
    [_cityBackgroundThird_02 setScale:0.5];
    
    [_cityFarBackgroundFirst_01 setScale:0.5];
    [_cityFarBackgroundFirst_02 setScale:0.5];
    
    [_cityFarBackgroundSecond_01 setScale:0.5];
    [_cityFarBackgroundSecond_02 setScale:0.5];
    
    
    [_cityBackgroundFirst_01 setPosition:CGPointMake(_cityBackgroundFirst_01.frame.size.width / 2, _groundHeight + _cityBackgroundFirst_01.frame.size.height * 1.65)];
    [_cityBackgroundFirst_02 setPosition:CGPointMake(_cityBackgroundFirst_01.frame.origin.x + _cityBackgroundFirst_01.frame.size.width, _groundHeight +  _cityBackgroundFirst_02.frame.size.height * 1.65)];

    
    [_cityBackgroundSecond_01 setPosition:CGPointMake(_cityBackgroundSecond_01.frame.size.width / 2, _groundHeight + _cityBackgroundSecond_01.frame.size.height )];
    [_cityBackgroundSecond_02 setPosition:CGPointMake(_cityBackgroundSecond_02.frame.origin.x + _cityBackgroundSecond_02.frame.size.width, _groundHeight +  _cityBackgroundSecond_02.frame.size.height)];
    
    [_cityBackgroundThird_01 setPosition:CGPointMake(_cityBackgroundThird_01.frame.size.width / 2, _groundHeight + _cityBackgroundThird_01.frame.size.height )];
    [_cityBackgroundThird_02 setPosition:CGPointMake(_cityBackgroundThird_02.frame.origin.x + _cityBackgroundThird_02.frame.size.width, _groundHeight +  _cityBackgroundThird_02.frame.size.height)];
    
    [_cityFarBackgroundFirst_01 setPosition:CGPointMake(_cityFarBackgroundFirst_01.frame.size.width / 2, _groundHeight + _cityFarBackgroundFirst_01.frame.size.height * 1.5)];
    [_cityFarBackgroundFirst_02 setPosition:CGPointMake(_cityFarBackgroundFirst_02.frame.origin.x + _cityFarBackgroundFirst_02.frame.size.width, _groundHeight +  _cityFarBackgroundFirst_02.frame.size.height * 1.5)];
    
    [_cityFarBackgroundSecond_01 setPosition:CGPointMake(_cityFarBackgroundSecond_01.frame.size.width / 2, _groundHeight + _cityFarBackgroundSecond_01.frame.size.height * 1.1)];
    [_cityFarBackgroundSecond_02 setPosition:CGPointMake(_cityFarBackgroundSecond_02.frame.origin.x + _cityFarBackgroundSecond_02.frame.size.width, _groundHeight +  _cityFarBackgroundSecond_02.frame.size.height * 1.1)];
    
    //Add sprites as child to scene
    [self addChild:_cityFarBackgroundSecond_01];
    [self addChild:_cityFarBackgroundSecond_02];
    
    [self addChild:_cityFarBackgroundFirst_01];
    [self addChild:_cityFarBackgroundFirst_02];

    [self addChild:_cityBackgroundThird_01];
    [self addChild:_cityBackgroundThird_02];
    [self addChild:_cityBackgroundSecond_01];
    [self addChild:_cityBackgroundSecond_02];


    
    [self addChild:_cityBackgroundFirst_01];
    [self addChild:_cityBackgroundFirst_02];
}

@end


