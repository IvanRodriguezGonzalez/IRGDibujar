//
//  IRGCanvasViewController.m
//  IRGDibujar
//
//  Created by Ivan Rodriguez Gonzalez on 26/10/14.
//  Copyright (c) 2014 IvanRodriguez. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "IRGCanvasViewController.h"
#import "IRGCeldaViewController.h"
#import "IRGAlmacenDeCeldas.h"
#import "IRGAlmacenDeCambios.h"
#import "IRGCeldaAlmacenada.h"
#import "IRGPincel.h"
#import "IRGLienzo.h"



@interface IRGCanvasViewController ()

@property (weak, nonatomic) IBOutlet UIView *barraDeIconos;
@property (weak, nonatomic) IBOutlet UIView *colorElegido;
@property (weak, nonatomic) IBOutlet UIView *canvas;

- (IBAction)accionRellenar:(UIButton *)sender;
- (IBAction)accionRellenarExtendido:(UIButton *)sender;
- (IBAction)accionPintar:(UIButton *)sender;
- (IBAction)retrocederVersion:(id)sender;
- (IBAction)avanzarVersion:(UIButton *)sender;
- (IBAction)accionBorrar:(UIButton *)sender;

- (IBAction)establecerColor:(UIButton *)sender;
- (IBAction)reducirCanvas:(UIButton *)sender;
- (IBAction)ampliarCanvas:(UIButton *)sender;
@end

@implementation IRGCanvasViewController

#pragma mark - Inicializadores

//designated initializer
-(instancetype) initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil{
    
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        
        UIBarButtonItem * botonIzquierdo = [[UIBarButtonItem alloc]
                                             initWithBarButtonSystemItem:UIBarButtonSystemItemRewind
                                             target:self
                                             action:@selector(retrocederVersion:)];
        
        UIBarButtonItem * botonDerecho=[[UIBarButtonItem alloc]
                                            initWithBarButtonSystemItem:UIBarButtonSystemItemFastForward
                                            target:self
                                            action:@selector(avanzarVersion:)];
        
        NSArray *botonesIzquierdos = @[botonIzquierdo];
        NSArray *botonesDerechos = @[botonDerecho];
        self.navigationItem.rightBarButtonItems = botonesDerechos;
        self.navigationItem.leftBarButtonItems = botonesIzquierdos;
    }
    return self;
}


#pragma mark - Overrides

- (void)viewDidLoad {
    [super viewDidLoad];
 
    [self crearAlmacenNuevo];
    [self dibujarCeldasDelLienzo];
    [self refrescarCanvasConCeldasCambiasdasEnTodasLasVersiones];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


#pragma mark - Navigation
/*
// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

- (IBAction)establecerColor:(UIButton *)sender {
    [IRGPincel sharedPincel].colorDeRellenoDelPincel = sender.backgroundColor ;
    self.colorElegido.backgroundColor = sender.backgroundColor;
}


- (IBAction)reducirCanvas:(UIButton *)sender {
    [IRGLienzo sharedLienzo].altoCelda = [IRGLienzo sharedLienzo].altoCelda-1;
    [IRGLienzo sharedLienzo].anchoCelda = [IRGLienzo sharedLienzo].anchoCelda-1;
    [self crearAlmacenNuevo];
    [self dibujarCeldasDelLienzo];
    [self refrescarCanvasConCeldasCambiasdasEnTodasLasVersiones];
}

- (IBAction)ampliarCanvas:(UIButton *)sender {
    [IRGLienzo sharedLienzo].altoCelda = [IRGLienzo sharedLienzo].altoCelda+1;
    [IRGLienzo sharedLienzo].anchoCelda = [IRGLienzo sharedLienzo].anchoCelda+1;
    [self crearAlmacenNuevo];
    [self dibujarCeldasDelLienzo];
    [self refrescarCanvasConCeldasCambiasdasEnTodasLasVersiones];
}

- (IBAction)accionRellenar:(id)sender {
    [IRGPincel sharedPincel].modoPincel = @"RellenarNormal";
    self.navigationItem.title = @"Rellenar";
    [IRGPincel sharedPincel].colorDeRellenoDelPincel = self.colorElegido.backgroundColor ;
}

- (IBAction)accionRellenarExtendido:(UIButton *)sender {
    [IRGPincel sharedPincel].modoPincel = @"RellenarExtendido";
    self.navigationItem.title = @"Rellenar extendido";
    [IRGPincel sharedPincel].colorDeRellenoDelPincel = self.colorElegido.backgroundColor ;
}

- (IBAction)accionPintar:(UIButton *)sender {
    [IRGPincel sharedPincel].modoPincel = @"Pintar";
    self.navigationItem.title = @"Pintar";
    [IRGPincel sharedPincel].colorDeRellenoDelPincel = self.colorElegido.backgroundColor ;
}

- (IBAction)retrocederVersion:(id)sender {
    
    NSArray * celdasCambiadasEnEstaVersion = [[IRGAlmacenDeCambios sharedAlmacenDeCambios] versionAnterior];
    if (celdasCambiadasEnEstaVersion){
        [self refrescarCanvasConCeldasCambiadas:celdasCambiadasEnEstaVersion
                             usarVersionAntigua:TRUE];
    }
}

- (IBAction)avanzarVersion:(UIButton *)sender {
    
    NSArray * celdasCambiadasEnEstaVersion = [[IRGAlmacenDeCambios sharedAlmacenDeCambios] versionSiguiente];
    if (celdasCambiadasEnEstaVersion){
        [self refrescarCanvasConCeldasCambiadas:celdasCambiadasEnEstaVersion
                             usarVersionAntigua:false];
    }
}

- (IBAction)accionBorrar:(UIButton *)sender {
    [IRGPincel sharedPincel].modoPincel = @"Borrar";
    self.navigationItem.title = @"Borrar";
    
}


#pragma mark - Propios

- (void) crearAlmacenNuevo{
    
    [[IRGAlmacenDeCeldas sharedAlmacenDeCeldas] borrarAlmacen];
    NSUInteger anchoDeLaCelda =[IRGLienzo sharedLienzo].anchoCelda;
    NSUInteger altoDeLaCelda = [IRGLienzo sharedLienzo].altoCelda;
    NSUInteger numeroDeFilas = [IRGLienzo sharedLienzo].filasDelLienzo;
    NSUInteger numeroDeColumnas  = [IRGLienzo sharedLienzo].columnasDelLienzo;
    
    NSUInteger numeroDeCelda;
    NSUInteger coordenadaX;
    NSUInteger coordenadaY;
    
    for (NSUInteger fila= 0; fila < numeroDeFilas;fila++){
        for (NSUInteger columna = 0 ;columna < numeroDeColumnas;columna++){
            
            coordenadaX = columna*anchoDeLaCelda;
            coordenadaY = fila*altoDeLaCelda;
            
            numeroDeCelda = [[[IRGAlmacenDeCeldas sharedAlmacenDeCeldas] allItems] count];
            
            IRGCeldaViewController *celdaViewController = [[IRGCeldaViewController alloc]
                                                           initWithPosicionX:coordenadaX
                                                           posicionY:coordenadaY
                                                           numeroDeCelda:numeroDeCelda
                                                           ancho:anchoDeLaCelda
                                                           alto:altoDeLaCelda];
            [[IRGAlmacenDeCeldas sharedAlmacenDeCeldas] añadirCelda:celdaViewController];
        }
    }
    [[IRGAlmacenDeCeldas sharedAlmacenDeCeldas] setNumeroDeColumnas:numeroDeColumnas];
}


- (void) dibujarCeldasDelLienzo{
    [self borrarCeldasDelLienzo];
    for (IRGCeldaViewController * celdaViewController in [IRGAlmacenDeCeldas sharedAlmacenDeCeldas].allItems){
        [self.canvas addSubview:celdaViewController.view];
    }
    self.navigationItem.title = [NSString stringWithFormat:@"%lu",(unsigned long)[[IRGAlmacenDeCeldas sharedAlmacenDeCeldas].allItems count]];
}

- (void) borrarCeldasDelLienzo{
    
    for(UIView *subview in self.canvas.subviews) {
        if (subview.class == [IRGCelda class]){
            [subview removeFromSuperview];
        }
    }
}

- (void) refrescarCanvasConCeldasCambiasdasEnTodasLasVersiones
{
    for (NSArray *versionAProcesar in [[IRGAlmacenDeCambios sharedAlmacenDeCambios]todasLasVersiones]){
        [self refrescarCanvasConCeldasCambiadas:versionAProcesar usarVersionAntigua:NO];
    }
    [[IRGAlmacenDeCambios sharedAlmacenDeCambios] setVersionActual:[[IRGAlmacenDeCambios sharedAlmacenDeCambios] numeroDeVersiones]];
}

- (void) refrescarCanvasConCeldasCambiadas:(NSArray *)celdasCambiadasEnEstaVersion
                        usarVersionAntigua:(bool) usarVersionAntigua{
    
    NSArray * todasLasCeldas = [[IRGAlmacenDeCeldas sharedAlmacenDeCeldas] allItems];
    IRGCeldaViewController * celdaViewController;
    
    for (IRGCeldaAlmacenada * celdaAlmacenada in celdasCambiadasEnEstaVersion){

        celdaViewController = [todasLasCeldas objectAtIndex:celdaAlmacenada.numeroDeCelda];
        if (usarVersionAntigua){
            [celdaViewController dibujarCeldaConCeldaAlmacenadaConVersionAntigua:celdaAlmacenada];
        }
        else {
            [celdaViewController dibujarCeldaConCeldaAlmacenadaConVersionNueva:celdaAlmacenada];
        }
    }
}


@end

