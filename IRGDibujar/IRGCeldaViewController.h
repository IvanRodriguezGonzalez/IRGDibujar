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
@property (nonatomic)BOOL rellenada;

//designated initialier

-(instancetype) initWithPosicionX:(NSUInteger)posicionX
                        posicionY:(NSUInteger)posicionY
                            ancho:(NSUInteger)ancho
                             alto:(NSUInteger)alto;



- (BOOL)esIgual:(IRGCeldaAlmacenada *)celdaViewController;

@end
