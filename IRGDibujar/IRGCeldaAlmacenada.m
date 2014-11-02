//
//  IRGCeldaAlmacenada.m
//  IRGDibujar
//
//  Created by Ivan Rodriguez Gonzalez on 29/10/14.
//  Copyright (c) 2014 IvanRodriguez. All rights reserved.
//

#import "IRGCeldaAlmacenada.h"

@implementation IRGCeldaAlmacenada

- (instancetype) initWithCeldaAlmacenada: (NSUInteger) numeroDeCelda
                  colorDelRellenoAntiguo:(UIColor *) colorDelRellenoAntiguo
                    colorDelRellenoNuevo:(UIColor *) colorDelRellenoNuevo
                    colorDelTrazoAntiguo: (UIColor *) colorDelTrazoAntiguo
                      colorDelTrazoNuevo:(UIColor *) colorDelTrazoNuevo
                   grosorDelTrazoAntiguo:(NSUInteger) grosorDelTrazoAntiguo
                     grosorDelTrazoNuevo:(NSUInteger) grosorDelTrazoNuevo {
    
    self = [super  init];
    if (self) {
        _numeroDeCelda = numeroDeCelda;
        _colorDelRellenoAntiguo = colorDelRellenoAntiguo;
        _colorDelRellenoNuevo = colorDelRellenoNuevo;
        _colorDelTrazoAntiguo = colorDelTrazoAntiguo;
        _colorDelTrazoNuevo = colorDelTrazoNuevo;
        _grosorDelTrazoAntiguo = grosorDelTrazoAntiguo;
        _grosorDelTrazoNuevo = grosorDelTrazoNuevo;

    }
    return self;
}

- (instancetype) init {
    [NSException exceptionWithName:@"Invalid init" reason:@"Use [IRGCeldaAlmacenada alloc] initWithCeldaAlmacenada..." userInfo:nil];
    return false;
}


@end
