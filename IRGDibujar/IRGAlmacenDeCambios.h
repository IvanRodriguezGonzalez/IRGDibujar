//
//  IRGAlmacenDeCambios.h
//  IRGDibujar
//
//  Created by Ivan Rodriguez Gonzalez on 29/10/14.
//  Copyright (c) 2014 IvanRodriguez. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "IRGCeldaViewController.h"

@interface IRGAlmacenDeCambios : NSObject
@property (nonatomic) int numeroDeVersiones;
@property (nonatomic) int versionActual;


//designated initializer

+ (instancetype) sharedAlmacenDeCambios;

- (void) nuevaVersionConCeldas: (NSArray *)celdas;

-(NSArray *) versionAnterior;

-(NSArray *) versionSiguiente;

@end
