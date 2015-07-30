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
    if(instance == NULL) {
        return instance = [ObstacleManager new];
    }
    return instance;
}

- (instancetype)init
{
    self = [super init];
    if (self) {
        _obstacles = [NSMutableArray array];
        _obstacleDefaultRange = 100;
    }
    return self;
}

//-----------------------------------------------------------
- (BOOL) canSpawnObstacle {
    if(self.obstacles.count <= 0)
        return YES;
    
    SKSpriteNode* lastNode = [self lastObstacle];
    if(SCREEN_WIDTH - lastNode.position.x + lastNode.size.width >= self.obstacleDefaultRange * 2)
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
    
    CGSize obstacleSize = CGSizeMake(obstacle.size.width / 3.5, obstacle.size.height / 3.2);
    obstacle.physicsBody = [SKPhysicsBody bodyWithRectangleOfSize:CGSizeMake(obstacle.size.width / 3.5, obstacle.size.height / 2.8)];
    obstacle.physicsBody.affectedByGravity = NO;
    obstacle.physicsBody.allowsRotation = NO;
    
    obstacle.physicsBody.contactTestBitMask = ColliderTypeActor;
    obstacle.physicsBody.collisionBitMask = ColliderTypeActor;
    obstacle.physicsBody.categoryBitMask = ColliderTypeObstacle;
    
    
    
    obstacle.anchorPoint = CGPointMake(0.5f, 0);
    obstacle.size = CGSizeMake(obstacle.size.width / 3.5, obstacle.size.height / 3.2);
    obstacle.position = CGPointMake(SCREEN_WIDTH + obstacle.frame.size.width * 3.5, self.rootScene.groundHeight - 25);
    
    
    SKAction* moveObstacle = [SKAction moveToX:-obstacle.size.width * 2.0f duration:2.7];
    [obstacle runAction:moveObstacle];
    [self.obstacles addObject:obstacle];
    
   
    
    
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


- (void)clearObstacles {
    [_obstacles removeAllObjects];
}

@end
