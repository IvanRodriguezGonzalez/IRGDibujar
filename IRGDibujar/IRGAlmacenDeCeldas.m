//
//  IRGAlmacenDeCeldas.m
//  IRGDibujar
//
//  Created by Leticia Vila Sexto on 27/10/14.
//  Copyright (c) 2014 IvanRodriguez. All rights reserved.
//

#import "IRGAlmacenDeCeldas.h"
#import "IRGCelda.h"
#import "IRGCeldaViewController.h"

@interface IRGAlmacenDeCeldas ()

@property (nonatomic) NSMutableArray *almacenDeCeldasPrivado;

@end

@implementation IRGAlmacenDeCeldas




-(instancetype) init {
    [NSException exceptionWithName:@"Invalid init" reason:@"Use [IRGAlmaceDeCeldas sharedAlmacenDeCeldas]" userInfo:nil];
    return false;
}


+ (instancetype) sharedAlmacenDeCeldas{
    
    static IRGAlmacenDeCeldas *_almacenDeCeldas;
    if(!_almacenDeCeldas){
        _almacenDeCeldas = [[IRGAlmacenDeCeldas alloc]initPrivado];
        
    }
    return _almacenDeCeldas;
}

-(instancetype) initPrivado{
    self = [super init];
    return self;
}

- (void) borrarAlmacen{
    self.almacenDeCeldasPrivado = [[NSMutableArray alloc]init];
}

- (void) añadirCelda: (IRGCeldaViewController *)celdaViewController{
    [self.almacenDeCeldasPrivado addObject:celdaViewController];
}

- (NSArray *) allItems {
    return [self.almacenDeCeldasPrivado copy];
}

- (NSMutableArray*) almacenDeCeldasPrivado{
    if (!_almacenDeCeldasPrivado){
        _almacenDeCeldasPrivado = [[NSMutableArray alloc]init];
    }
    return _almacenDeCeldasPrivado;
}


- (bool) hayCeldasEnLaFla:(NSUInteger) numeroDeFila
              conColumnas:(NSUInteger) numeroDeColumnas{
    if ((numeroDeFila * numeroDeColumnas)< self.allItems.count){
        return true;
    }
    else{
        return false;
    }
}

- (NSArray *) celdasDeLaFila:(NSUInteger) numeroDeFila
                 conColumnas:(NSUInteger) numeroDeColumnas{
    NSMutableArray *arrayTemporal = [[NSMutableArray alloc] init];
    NSUInteger contadorDeCeldas = 0;
    NSUInteger celdaInicio = numeroDeFila*numeroDeColumnas;
    
    while ((contadorDeCeldas < numeroDeColumnas) & (contadorDeCeldas+celdaInicio < self.allItems.count)){
        [arrayTemporal addObject:self.almacenDeCeldasPrivado[contadorDeCeldas+celdaInicio]];
         contadorDeCeldas++;
    }
         return arrayTemporal;
}

- (IRGCeldaViewController *) siguienteCeldaEnLaFila: (IRGCeldaViewController *)celdaOriginal{
    if (((celdaOriginal.numeroDeCelda+1) < self.almacenDeCeldasPrivado.count) &
        ( ((celdaOriginal.numeroDeCelda+1) % self.numeroDeColumnas) !=0)){
        return self.almacenDeCeldasPrivado[celdaOriginal.numeroDeCelda+1];
    }
    else {
        return nil;
    }

}


- (IRGCeldaViewController *) anteriorCeldaEnLaFila: (IRGCeldaViewController *)celdaOriginal{
    if (((celdaOriginal.numeroDeCelda) > 0) &
        ( ((celdaOriginal.numeroDeCelda) % self.numeroDeColumnas) !=0)){
        return self.almacenDeCeldasPrivado[celdaOriginal.numeroDeCelda-1];
    }
    else {
        return nil;
    }
    
}

- (IRGCeldaViewController *) celdaEnLaFilaSuperior: (IRGCeldaViewController *)celdaOriginal{
    if (celdaOriginal.numeroDeCelda >= self.numeroDeColumnas ){
        return self.almacenDeCeldasPrivado[celdaOriginal.numeroDeCelda-self.numeroDeColumnas];
    }
    else {
        return nil;
    }

}


- (IRGCeldaViewController *) celdaEnLaFilaInferior: (IRGCeldaViewController *)celdaOriginal{
    if ((celdaOriginal.numeroDeCelda+self.numeroDeColumnas) < self.almacenDeCeldasPrivado.count ){
        return self.almacenDeCeldasPrivado[celdaOriginal.numeroDeCelda+self.numeroDeColumnas];
    }
    else {
        return nil;
    }
    
}


@end
