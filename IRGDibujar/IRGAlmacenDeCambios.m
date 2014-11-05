//
//  IRGAlmacenDeCambios.m
//  IRGDibujar
//
//  Created by Ivan Rodriguez Gonzalez on 29/10/14.
//  Copyright (c) 2014 IvanRodriguez. All rights reserved.
//

#import "IRGAlmacenDeCambios.h"
#import "IRGAlmacenDeCeldas.h"
#import "IRGCeldaViewController.h"

@interface IRGAlmacenDeCambios ()

@property (nonatomic) NSMutableArray * versiones;
@property (nonatomic,readonly) NSString * nombreDelArchivo;

@end

@implementation IRGAlmacenDeCambios


#pragma mark - Inicializadores

//designated initilizer
+ (instancetype) sharedAlmacenDeCambios{
    
    static IRGAlmacenDeCambios *_almaceDeCambios;
    
    if(!_almaceDeCambios){
        _almaceDeCambios = [[IRGAlmacenDeCambios alloc] initPrivado];
    }
    return _almaceDeCambios;
}


-(instancetype) initPrivado{
    self = [super init];
    
    NSFileManager *fileManagerPrincipal = [NSFileManager defaultManager];
    
    if ([fileManagerPrincipal fileExistsAtPath:   [self pathDelArchivoConHistorialDeCambios] ]){
        _versiones = [NSKeyedUnarchiver unarchiveObjectWithFile: [self pathDelArchivoConHistorialDeCambios]];
    }
    else {
        _versiones = [[NSMutableArray alloc] init];
    }
    
    self.numeroDeVersiones = self.versiones.count;
    return self;
}

-(instancetype) init {
    [NSException exceptionWithName:@"Invalid init" reason:@"Use [IRGAlmaceDeCambios sharedAlmacenDeCambios]" userInfo:nil];
    return false;
}



#pragma mark - Accesors

- (NSString *) nombreDelArchivo{
    return @"Dibujo.historial";
}


#pragma mark  - Propios - publicos


-(bool) grabarCambios{
    
    [self eliminaVersionesDesdeLaVersionActual];
    return [NSKeyedArchiver archiveRootObject:self.versiones toFile:[self pathDelArchivoConHistorialDeCambios]];
}

- (void) nuevaVersionConCeldas: (NSArray *)celdas{
    

    [self eliminaVersionesDesdeLaVersionActual];
    self.numeroDeVersiones = self.versionActual;
    [self.versiones addObject:celdas];
    self.numeroDeVersiones = self.numeroDeVersiones+1;
    self.versionActual = self.numeroDeVersiones;
}

-(NSArray *) versionAnterior {
    if (self.versionActual > 0){
        self.versionActual = self.versionActual-1;
        return [self.versiones objectAtIndex:self.versionActual];
    } else
        return nil;
    
}

- (NSArray *) versionSiguiente {
    if(self.versionActual < self.numeroDeVersiones){
        self.versionActual = self.versionActual+1;}
    
    if (self.numeroDeVersiones>0)
        {
        return [self.versiones objectAtIndex:self.versionActual-1];
        }
    else
        {
        return nil;
        }
}

- (NSArray *)todasLasVersiones{
    return _versiones;
}

#pragma mark - Propios - privados

- (NSString *) pathDelArchivoConHistorialDeCambios{
    NSString * directorio = @"/Users/LVS/Desktop/Dibujos";
    return [directorio stringByAppendingPathComponent:self.nombreDelArchivo];
}

- (void) eliminaVersionesDesdeLaVersionActual{
    int  versionesAEliminar = self.numeroDeVersiones - self.versionActual;
    
    for (int i = 0;i<versionesAEliminar;i++){
        [self.versiones removeLastObject];
    }
}

@end
