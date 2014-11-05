//
//  IRGAlmacenDeCeldas.h
//  IRGDibujar
//
//  Created by Leticia Vila Sexto on 27/10/14.
//  Copyright (c) 2014 IvanRodriguez. All rights reserved.
//

#import <Foundation/Foundation.h>
@class IRGCeldaViewController;

@interface IRGAlmacenDeCeldas : NSObject
@property (nonatomic) NSUInteger numeroDeColumnas;

+ (instancetype) sharedAlmacenDeCeldas;


- (void) borrarAlmacen;
- (void) añadirCelda: (IRGCeldaViewController *)celda;

- (bool) hayCeldasEnLaFla:(NSUInteger) numeroDeFila;

- (NSUInteger) celdaDePosicionX:(int)posicionX posicionY:(int) posicionY;


- (IRGCeldaViewController *) siguienteCeldaEnLaFila: (IRGCeldaViewController *)celdaOriginal;
- (IRGCeldaViewController *) anteriorCeldaEnLaFila: (IRGCeldaViewController *)celdaOriginal;
- (IRGCeldaViewController *) celdaEnLaFilaSuperior: (IRGCeldaViewController *)celdaOriginal;
- (IRGCeldaViewController *) celdaEnLaFilaInferior: (IRGCeldaViewController *)celdaOriginal;


- (NSArray *) allItems;

@end
