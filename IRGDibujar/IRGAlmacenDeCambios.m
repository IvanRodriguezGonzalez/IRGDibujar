//
//  IRGAlmacenDeCambios.m
//  IRGDibujar
//
//  Created by Ivan Rodriguez Gonzalez on 29/10/14.
//  Copyright (c) 2014 IvanRodriguez. All rights reserved.
//

#import "IRGAlmacenDeCambios.h"

@interface IRGAlmacenDeCambios ()

@property (nonatomic) NSMutableArray * versiones;

@end

@implementation IRGAlmacenDeCambios


#pragma mark Inicializadores

//designated initilizer
+ (instancetype) sharedAlmacenDeCambios{
    
    static IRGAlmacenDeCambios *_almaceDeCambios;
    if(!_almaceDeCambios){
        _almaceDeCambios = [[IRGAlmacenDeCambios alloc] initPrivado];
        
    }
    return _almaceDeCambios;
}


-(instancetype) initPrivado{
    self = [super init];
    self.versiones = [[NSMutableArray alloc] init];
    self.versiones[0] = [NSNull null];
    return self;
}

-(instancetype) init {
    [NSException exceptionWithName:@"Invalid init" reason:@"Use [IRGAlmaceDeCambios sharedAlmacenDeCambios]" userInfo:nil];
    return false;
}

#pragma mark Propios

- (void) nuevaVersionConCeldas: (NSArray *)celdas{
    
    int  versionesAEliminar = self.numeroDeVersiones - self.versionActual;
    
    for (int i = 0;i<versionesAEliminar;i++){
        [self.versiones removeLastObject];
    }
    
    self.numeroDeVersiones = self.versionActual;

    [self.versiones addObject:celdas];
    self.numeroDeVersiones = self.numeroDeVersiones+1;
    self.versionActual = self.numeroDeVersiones;
}

-(NSArray *) versionAnterior {
    if (self.versionActual > 0){
        self.versionActual = self.versionActual-1;
        return [self.versiones objectAtIndex:self.versionActual+1];
    } else
        return [self.versiones objectAtIndex:self.versionActual];
    
}

- (NSArray *) versionSiguiente {
    if(self.versionActual < self.numeroDeVersiones){
        self.versionActual = self.versionActual+1;}
    
    return [self.versiones objectAtIndex:self.versionActual];
}

@end
