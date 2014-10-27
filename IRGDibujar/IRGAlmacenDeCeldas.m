//
//  IRGAlmacenDeCeldas.m
//  IRGDibujar
//
//  Created by Leticia Vila Sexto on 27/10/14.
//  Copyright (c) 2014 IvanRodriguez. All rights reserved.
//

#import "IRGAlmacenDeCeldas.h"
#import "IRGCelda.h";

@interface IRGAlmacenDeCeldas ()

@property (nonatomic) NSMutableArray *almacenDeCeldasPrivado;

@end

@implementation IRGAlmacenDeCeldas




-(instancetype) init {
    [NSException exceptionWithName:@"Invalid init" reason:@"Use [IRGAlmaceDeCeldas sharedAlmacenDeCeldas]" userInfo:nil];
    return false;
}


+ (instancetype) sharedAlmacenDeCeldas{
    
    static IRGAlmacenDeCeldas *_almaceDeCeldas;
    if(!_almaceDeCeldas){
        _almaceDeCeldas = [[IRGAlmacenDeCeldas alloc]initPrivado];
    }
    return _almaceDeCeldas;
}

-(instancetype) initPrivado{
    self = [super init];
    return self;
}

- (void) añadirCelda: (IRGCelda *)celda{
    [self.almacenDeCeldasPrivado addObject:celda];
}

- (NSArray *) allItems {
    return [self.almacenDeCeldasPrivado copy];
}

@end
