//
//  IRGCeldaAlmacenada.m
//  IRGDibujar
//
//  Created by Ivan Rodriguez Gonzalez on 29/10/14.
//  Copyright (c) 2014 IvanRodriguez. All rights reserved.
//

#import "IRGCeldaAlmacenada.h"

@implementation IRGCeldaAlmacenada

- (instancetype) initWithCeldaAlmacenada: (CGRect) frame
                 colorDelRellenoAntiguo:(UIColor *)colorDelRellenoAntiguo
                    colorDelRellenoNuevo:(UIColor *) colorDelRellenoNuevo
                        rellenadaAntigua: (bool) rellenadaAntigua
                          rellenadaNueva: (bool) rellenadaNueva;{
    
    self = [super  init];
    if (self) {
        _colorDelRellenoAntiguo = colorDelRellenoAntiguo;
        _colorDelRellenoNuevo = colorDelRellenoNuevo;
        _frame = frame;
        _rellenadaAntigua = rellenadaAntigua;
        _rellenadaNueva = rellenadaNueva;
    }
    return self;
}

- (instancetype) init {
    [NSException exceptionWithName:@"Invalid init" reason:@"Use [IRGCeldaAlmacenada alloc] initWithCeldaAlmacenada..." userInfo:nil];
    return false;
}


@end
