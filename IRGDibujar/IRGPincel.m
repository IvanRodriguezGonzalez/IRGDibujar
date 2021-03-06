//
//  IRGPincel.m
//  IRGDibujar
//
//  Created by Leticia Vila Sexto on 1/11/14.
//  Copyright (c) 2014 IvanRodriguez. All rights reserved.
//

#import "IRGPincel.h"
#import "IRGLienzo.h"

@implementation IRGPincel

#pragma mark - Inicializadores

-(instancetype) init {
    [NSException exceptionWithName:@"Invalid init" reason:@"Use [IRGPincel sharedPincel]" userInfo:nil];
    return false;
}

//designated initializer
+ (instancetype) sharedPincel{
    
    static IRGPincel *_pincel;
    if(!_pincel){
        _pincel = [[IRGPincel alloc]initPrivado];
    }
    return _pincel;
}

-(instancetype) initPrivado{
    self = [super init];
    if (self) {
        [self establecerPincelPorDefecto];
    }
    return self;
}

- (void) establecerPincelPorDefecto{
    self.colorDeTrazoDelPincel = [UIColor lightGrayColor];
    self.colorDeRellenoDelPincel = [UIColor blackColor];
    self.grosorDelTrazoDelPincel = 1;
    _modoPincel = @"Pintar";
}

#pragma mark - Accesosr

-(void) setModoPincel:(NSString *)modoPincel{
    _modoPincel = modoPincel;
    if ([modoPincel isEqualToString:@"Borrar"]){
        self.colorDeTrazoDelPincel = [IRGLienzo sharedLienzo].colorDelTrazoDeLaCeldaSinPintar ;
        self.colorDeRellenoDelPincel = [IRGLienzo sharedLienzo].colorDelRellenoDeLaCeldaSinPintar;
        self.grosorDelTrazoDelPincel = [IRGPincel sharedPincel].grosorDelTrazoDelPincel;
    }
}



@end
