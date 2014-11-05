//
//  IRGCeldaProtocol.h
//  IRGDibujar
//
//  Created by Ivan Rodriguez Gonzalez on 26/10/14.
//  Copyright (c) 2014 IvanRodriguez. All rights reserved.
//

#import <Foundation/Foundation.h>
@class IRGCelda;

@protocol IRGCeldaProtocol

- (void) inicioDeTouch:(IRGCelda *) sender;
- (void) movimientoDuranteTouch:(IRGCelda *) sender
                        posicionX:(int)posicionX
                        posicionY:(int)posicionY;
- (void) finDeTouch: (IRGCelda *) sender;

@end
