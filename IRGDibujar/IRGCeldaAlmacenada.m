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


- (void) encodeWithCoder:(NSCoder *)aCoder{
    
    [aCoder encodeInteger:self.numeroDeCelda forKey:@"numeroDeCelda"];
    [aCoder encodeObject:self.colorDelRellenoNuevo forKey:@"colorDelRellenoNuevo"];
    [aCoder encodeObject:self.colorDelTrazoNuevo forKey:@"colorDelTrazoNuevo"];
    [aCoder encodeInteger:self.grosorDelTrazoNuevo forKey:@"grosorDelTrazoNuevo"];
    [aCoder encodeObject:self.colorDelRellenoAntiguo forKey:@"colorDelRellenoAntiguo"];
    [aCoder encodeObject:self.colorDelTrazoAntiguo forKey:@"colorDelTrazoAntiguo"];
    [aCoder encodeInteger:self.grosorDelTrazoAntiguo forKey:@"grosorDelTrazoAntiguo"];
    
}



- (instancetype) initWithCoder: (NSCoder *)aDecoder {
    self = [super init];
    if (self){
        _numeroDeCelda = [aDecoder decodeIntegerForKey:@"numeroDeCelda"];
        _colorDelRellenoNuevo = [aDecoder decodeObjectForKey:@"colorDelRellenoNuevo"];
        _colorDelTrazoNuevo = [aDecoder decodeObjectForKey:@"colorDelTrazoNuevo"];
        _grosorDelTrazoNuevo = [aDecoder decodeIntegerForKey:@"grosorDelTrazoNuevo"];
        _colorDelRellenoAntiguo = [aDecoder decodeObjectForKey:@"colorDelRellenoAntiguo"];
        _colorDelTrazoAntiguo = [aDecoder decodeObjectForKey:@"colorDelTrazoAntiguo"];
        _grosorDelTrazoAntiguo = [aDecoder decodeIntegerForKey:@"grosorDelTrazoAntiguo"];
        
    }
    return self;
}

@end
