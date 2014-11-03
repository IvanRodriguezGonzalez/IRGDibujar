//
//  IRGLienzo.m
//  IRGDibujar
//
//  Created by Leticia Vila Sexto on 1/11/14.
//  Copyright (c) 2014 IvanRodriguez. All rights reserved.
//

#import "IRGLienzo.h"

@implementation IRGLienzo


-(instancetype) init {
    [NSException exceptionWithName:@"Invalid init" reason:@"Use [IRGLienzo sharedLienzo]" userInfo:nil];
    return false;
}
//designated initializer
+ (instancetype) sharedLienzo{
    
    static IRGLienzo *_lienzo;
    if(!_lienzo){
        _lienzo = [[IRGLienzo alloc]initPrivado];
    }
    return _lienzo;
}

-(instancetype) initPrivado{
    self = [super init];
    
    if (self) {
        [self establecerCeldaSinPintarPorDefecto];
    }
    return self;
}

- (void) establecerCeldaSinPintarPorDefecto {
    
    self.colorDelTrazoDeLaCeldaSinPintar = [UIColor lightGrayColor];
    self.colorDelRellenoDeLaCeldaSinPintar = [UIColor whiteColor];
    self.grosoDelTrazoDeLaCeldaSinPintar = 1;
}

@end
