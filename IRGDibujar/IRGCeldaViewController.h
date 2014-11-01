//
//  IRGCeldaViewController.h
//  IRGDibujar
//
//  Created by Ivan Rodriguez Gonzalez on 26/10/14.
//  Copyright (c) 2014 IvanRodriguez. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "IRGCelda.h"
#import "IRGCeldaProtocol.h"
#import "IRGCeldaAlmacenada.h"

@interface IRGCeldaViewController : UIViewController<IRGCeldaProtocol>

@property (nonatomic,readonly)IRGCelda * celda;
@property (nonatomic) NSUInteger numeroDeCelda;
@property (nonatomic)BOOL rellenada;
@property (nonatomic) NSUInteger numeroDeFila;
@property (nonatomic) NSUInteger numeroDeColumna;


//designated initialier

-(instancetype) initWithPosicionX:(NSUInteger)posicionX
                        posicionY:(NSUInteger)posicionY
                    numeroDeCelda:(NSUInteger)numeroDeCelda
                            ancho:(NSUInteger)ancho
                             alto:(NSUInteger)alto;



- (BOOL)esIgual:(IRGCeldaAlmacenada *)celdaViewController;

@end
