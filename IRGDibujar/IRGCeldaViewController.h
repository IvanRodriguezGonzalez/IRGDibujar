//
//  IRGCeldaViewController.h
//  IRGDibujar
//
//  Created by Ivan Rodriguez Gonzalez on 26/10/14.
//  Copyright (c) 2014 IvanRodriguez. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "IRGCeldaProtocol.h"

@interface IRGCeldaViewController : UIViewController<IRGCeldaProtocol>

//designated initialier

-(instancetype) initWithPosicionX:(NSUInteger)posicionX
                        posicionY:(NSUInteger)posicionY
                            ancho:(NSUInteger)ancho
                             alto:(NSUInteger)alto;



@end
