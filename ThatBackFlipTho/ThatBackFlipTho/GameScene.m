//
//  GameScene.m
//  ThatBackFlipTho
//
//  Created by Максим on 03.07.15.
//  Copyright (c) 2015 200GO. All rights reserved.
//

#import "GameScene.h"

@implementation GameScene

//---------------------------------------------------------------
-(void)didMoveToView:(SKView *)view {
    
    [self prepareGroundToMove];
    [self prepareCityToMove];
    [self prepareCityPositionAndScale];
    
    _groundHeight = _ground_01.frame.size.height;
    
    //_bach = [SKSpriteNode spriteNodeWithImageNamed:@"kingBach_01"];
    //[_bach setPosition:CGPointMake(50, _groundHeight + 100)];
    _bach = [self childNodeWithName:@"bach"];
    //[_bach setScale:0.5f];
    
    SKTextureAtlas* atlas = [SKTextureAtlas atlasNamed:@"animation"];
    NSMutableArray* tempAnimations = [NSMutableArray new];
    for(int i = 1; i < atlas.textureNames.count; i++) {
        SKTexture* texture = [atlas textureNamed:[NSString stringWithFormat:@"kingBach_0%d",i]];
        [tempAnimations addObject:texture];
    }
    _runAnimation = [NSArray arrayWithArray:tempAnimations];
    [self addChild:_bach];
}

//---------------------------------------------------------------
-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event {

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
    [self updatePlayer];
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


- (void) updatePlayer {
    SKAction* actionPlayRunAnimation = [SKAction animateWithTextures:_runAnimation timePerFrame:0.1];
    [_bach runAction:actionPlayRunAnimation];
}

//---------------------------------------------------------------
//Описание:
//Функция подготавливает элементы земли к бесконечному перемещению
- (void) prepareGroundToMove {
    self.ground_01 = [self childNodeWithName:@"ground_01"];
    self.ground_02 = [self childNodeWithName:@"ground_02"];
    SKAction* moveGround01Sprite = [SKAction moveByX:-_ground_01.frame.size.width * 50 y:0 duration:0.1 * _ground_01.frame.size.width * 2];
    SKAction* moveGround02Sprite = [SKAction moveByX:-_ground_02.frame.size.width * 50 y:0 duration:0.1 * _ground_02.frame.size.width * 2];
    
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
    SKAction* moveCityFirst_01 = [SKAction moveByX:-self.cityBackgroundFirst_01.frame.size.width * 50 y:0 duration:0.1 * self.cityBackgroundFirst_01.frame.size.width * 2];
    SKAction* moveCityFirst_02 = [SKAction moveByX:-self.cityBackgroundFirst_02.frame.size.width * 50 y:0 duration:0.1 * self.cityBackgroundFirst_02.frame.size.width * 2];
    
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


