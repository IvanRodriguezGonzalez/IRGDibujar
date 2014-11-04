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



@interface IRGCanvasViewController ()

@property (weak, nonatomic) IBOutlet UIView *barraDeIconos;
@property (weak, nonatomic) IBOutlet UIView *colorElegido;

- (IBAction)accionRellenar:(UIButton *)sender;
- (IBAction)accionRellenarExtendido:(UIButton *)sender;
- (IBAction)accionPintar:(UIButton *)sender;
- (IBAction)retrocederVersion:(id)sender;
- (IBAction)avanzarVersion:(UIButton *)sender;
- (IBAction)accionBorrar:(UIButton *)sender;

- (IBAction)establecerColor:(UIButton *)sender;
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
 
    self.view.frame = [[UIApplication sharedApplication] keyWindow].frame;
    
    NSUInteger posicionX;
    NSUInteger posicionY =  70;
    NSUInteger ancho =30;
    NSUInteger alto =30;
    
    NSUInteger numeroDeCelda;
    NSUInteger altoBarraDeIconos = self.barraDeIconos.frame.size.height;
    NSUInteger anchoDeLaVentana = self.view.frame.size.width;
    
    
    NSUInteger numeroDeCeldasEnCadaFila = (anchoDeLaVentana) / ancho;
    NSUInteger bordeHorizontal = anchoDeLaVentana - numeroDeCeldasEnCadaFila*ancho;
    
    posicionX = bordeHorizontal/2;
    
    
    for (NSUInteger coordenadaY = posicionY+altoBarraDeIconos;coordenadaY+alto<=self.view.frame.size.height;coordenadaY+= alto){
        for (NSUInteger coordenadax = posicionX;coordenadax+ancho<=anchoDeLaVentana;coordenadax += ancho){
                
            numeroDeCelda = [[[IRGAlmacenDeCeldas sharedAlmacenDeCeldas] allItems] count];
            
            IRGCeldaViewController *celdaViewController = [[IRGCeldaViewController alloc]
                                                           initWithPosicionX:coordenadax
                                                           posicionY:coordenadaY
                                                           numeroDeCelda:numeroDeCelda
                                                           ancho:ancho
                                                           alto:alto];
        [[IRGAlmacenDeCeldas sharedAlmacenDeCeldas] añadirCelda:celdaViewController];
        [self.view addSubview:celdaViewController.view];
        }}
    
    NSArray *todasLasCeldas = [[IRGAlmacenDeCeldas sharedAlmacenDeCeldas]allItems];
    for (NSArray *versionAProcesar in [[IRGAlmacenDeCambios sharedAlmacenDeCambios]todasLasVersiones]){
        for (IRGCeldaAlmacenada *celdaAlmacenadaAProcesar in versionAProcesar)
        {
            [todasLasCeldas[celdaAlmacenadaAProcesar.numeroDeCelda] dibujarCeldaConCeldaAlmacenadaConVersionNueva:celdaAlmacenadaAProcesar];
        }
    }
    [[IRGAlmacenDeCambios sharedAlmacenDeCambios] setVersionActual:[[IRGAlmacenDeCambios sharedAlmacenDeCambios] numeroDeVersiones]];

    
    [[IRGAlmacenDeCeldas sharedAlmacenDeCeldas] setNumeroDeColumnas:numeroDeCeldasEnCadaFila];
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

