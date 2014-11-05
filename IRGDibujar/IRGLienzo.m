//
//  IRGLienzo.m
//  IRGDibujar
//
//  Created by Leticia Vila Sexto on 1/11/14.
//  Copyright (c) 2014 IvanRodriguez. All rights reserved.
//

#import "IRGLienzo.h"

# define ALTO_DE_LA_CELDA 20
# define ANCHO_DE_LA_CELDA 20
# define FILAS_DEL_LIENZO 20
# define COLUMNAS_DEL_LIENZO 20
# define TAMANO_MINIMO_PARA_PINTAR_BORDE 5



@implementation IRGLienzo


-(instancetype) init {
    [NSException exceptionWithName:@"Invalid init" reason:@"Use [IRGLienzo sharedLienzo]" userInfo:nil];
    return false;
}
//designated initializer
+ (instancetype) sharedLienzo{
    
    static IRGLienzo *_lienzo;
    if(!_lienzo){
        _lienzo = [[IRGLienzo alloc]initPrivado];
    }
    return _lienzo;
}

-(instancetype) initPrivado{
    self = [super init];
    
    if (self) {
        [self establecerCeldaSinPintarPorDefecto];
    }
    return self;
}

#pragma mark - Accesors

- (void) establecerCeldaSinPintarPorDefecto {
    self.colorDelTrazoDeLaCeldaSinPintar = [UIColor lightGrayColor];
    self.colorDelRellenoDeLaCeldaSinPintar = [UIColor clearColor];
    self.grosoDelTrazoDeLaCeldaSinPintar = 1;
}


-(NSInteger) filasDelLienzo {
    if (_filasDelLienzo == 0) {
        _filasDelLienzo = FILAS_DEL_LIENZO;
    }
    return  _filasDelLienzo;
}

-(NSInteger) columnasDelLienzo {
    if (_columnasDelLienzo ==0) {
        _columnasDelLienzo = COLUMNAS_DEL_LIENZO;
    }
    return _columnasDelLienzo;
}

-(NSInteger) anchoCelda{
    if (_anchoCelda == 0) {
        _anchoCelda = ANCHO_DE_LA_CELDA;
    }
    return _anchoCelda;
}

-(NSInteger) altoCelda{
    if (_altoCelda==0) {
        _altoCelda = ALTO_DE_LA_CELDA;
    }
    return _altoCelda;
}

#pragma mark - Propios Publicos

-(bool) dibujarBorderDeLaCelda{
    if ((self.altoCelda>TAMANO_MINIMO_PARA_PINTAR_BORDE) & (self.anchoCelda>TAMANO_MINIMO_PARA_PINTAR_BORDE)){
        return TRUE;
    }
    else {
        return FALSE;
    }
}

@end
