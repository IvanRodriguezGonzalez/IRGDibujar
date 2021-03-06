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


//designated initialier

-(instancetype) initWithPosicionX:(NSUInteger)posicionX
                        posicionY:(NSUInteger)posicionY
                    numeroDeCelda:(NSUInteger)numeroDeCelda
                            ancho:(NSUInteger)ancho
                             alto:(NSUInteger)alto;





- (void) actualizarViewControllerYDibujaCeldaConColorDelTrazoDeLaCelda:(UIColor *) colorDelTrazoDeLaCelda
                                              colorDelRellenoDeLaCelda:(UIColor *) colorDelRellenoDeLaCelda
                                              grosorDelPincelDeLaCElda:(NSUInteger) grosorDelPincelDeLaCelda;

- (void) dibujaCeldaConPincel;
- (void) dibujarCeldaConCeldaAlmacenadaConVersionAntigua:(IRGCeldaAlmacenada *)celdaAlmacenada;
- (void) dibujarCeldaConCeldaAlmacenadaConVersionNueva:(IRGCeldaAlmacenada *)celdaAlmacenada;
- (void) borrarYGuardarCeldaDelViewController:(IRGCeldaViewController *) celdaViewController;


@end
