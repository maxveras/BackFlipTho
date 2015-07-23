//
//  Common.h
//  ThatBackFlipTho
//
//  Created by Andew Medvedev on 13.07.15.
//  Copyright (c) 2015 200GO. All rights reserved.
//

#import <Foundation/Foundation.h>

//Перечисление типов объектов, с которыми можем столкнуться
//Другими словами колайдер для каждого типа объекта
typedef enum {
    ColliderTypeActor,
    ColliderTypeGround,
    ColliderTypeObstacle
} ColliderType;


static float baseLevelSpeed;
static float groundHeight;

@interface Common : NSObject

@end
