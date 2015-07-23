//
//  ObstacleManager.m
//  ThatBackFlipTho
//
//  Created by Andrew Medvedev on 23.07.15.
//  Copyright (c) 2015 200GO. All rights reserved.
//

#import "ObstacleManager.h"
#import "Common.h"
#import "GameScene.h"

static ObstacleManager* instance;

@interface ObstacleManager()
@property(strong, nonatomic) NSMutableArray* obstacles;
@end



@implementation ObstacleManager

+ (instancetype) getInstance {
    if(instance == NULL)
        return instance = [ObstacleManager new];
    return instance;
}

//-----------------------------------------------------------
- (BOOL) canSpawnObstacle {
    if(self.obstacles.count <= 0)
        return YES;
    
    SKSpriteNode* lastNode = [self lastObstacle];
    if(SCREEN_WIDTH - lastNode.position.x >= self.obstacleDefaultRange)
        return YES;
    
    return NO;
}

//-----------------------------------------------------------
- (SKSpriteNode*) prepareObstacle:(NSString*) name {
//    SKSpriteNode* simpleObstacle = [SKSpriteNode spriteNodeWithColor:[UIColor redColor] size:CGSizeMake(64, 128)];
//    //SKSpriteNode* n = [[SKSpriteNode alloc] initWithColor:red size:size];
//    simpleObstacle.name = @"simple";
//    return simpleObstacle;
    return NULL;
}

//-----------------------------------------------------------
- (void) spawnObstacle:(SKSpriteNode*) obstacle {
    obstacle.name = @"simple";
    [self.rootScene spawnObstacle:obstacle];
    //[self.scene addChild:obstacle];
    
    obstacle.physicsBody.affectedByGravity = NO;
    obstacle.physicsBody.allowsRotation = NO;
    
    obstacle.physicsBody.contactTestBitMask = ColliderTypeGround | ColliderTypeActor;
    obstacle.physicsBody.collisionBitMask = ColliderTypeGround | ColliderTypeActor;
    obstacle.physicsBody.categoryBitMask = ColliderTypeObstacle;
    
    
    obstacle.anchorPoint = CGPointMake(0.5f, 0);
    obstacle.position = CGPointMake(SCREEN_WIDTH + obstacle.frame.size.width, self.rootScene.groundHeight);
    obstacle.size 
    
    SKAction* moveObstacle = [SKAction moveToX:-obstacle.size.width * 2.0f duration:4];
    [obstacle runAction:moveObstacle];
    
    
   
    
    
}

//-----------------------------------------------------------
- (BOOL) obstacleOutOfScreen:(SKSpriteNode*) obstacle {
    if(obstacle.position.x < obstacle.size.width * 2.0f)
        return YES;
    return NO;
}

//-----------------------------------------------------------
- (SKSpriteNode*) lastObstacle {
    return [self.obstacles lastObject];
}

//-----------------------------------------------------------
- (void) update:(CFTimeInterval) currentTime {
    if([self canSpawnObstacle] == YES) {
        SKSpriteNode* simpleObstacle = [SKSpriteNode spriteNodeWithImageNamed:@"Budka.png"];
        [self spawnObstacle:simpleObstacle];
    }
}


@end
