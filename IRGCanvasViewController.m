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
- (void) seleccionarColor;

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
    NSUInteger ancho =15;
    NSUInteger alto =15;
    
    NSUInteger numeroDeCelda;
    NSUInteger anchoBarraDeIconos = self.barraDeIconos.frame.size.width;
    NSUInteger anchoDeLaVentana = self.view.frame.size.width;
    
    
    NSUInteger numeroDeCeldasEnCadaFila = (anchoDeLaVentana - anchoBarraDeIconos) / ancho;
    NSUInteger bordeHorizontal = anchoDeLaVentana - numeroDeCeldasEnCadaFila*ancho- anchoBarraDeIconos;
    
    posicionX = anchoBarraDeIconos + (bordeHorizontal/2);
    
    
    for (NSUInteger coordenadaY = posicionY;coordenadaY+alto<=self.view.frame.size.height;coordenadaY+= alto){
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
}

- (IBAction)accionRellenarExtendido:(UIButton *)sender {
    [IRGPincel sharedPincel].modoPincel = @"RellenarExtendido";
    self.navigationItem.title = @"Rellenar extendido";
}

- (IBAction)accionPintar:(UIButton *)sender {
    [IRGPincel sharedPincel].modoPincel = @"Pintar";
    self.navigationItem.title = @"Pintar";
}

- (IBAction)retrocederVersion:(id)sender {
    NSArray * celdasCambiadasEnEstaVersion = [[IRGAlmacenDeCambios sharedAlmacenDeCambios] versionAnterior];
    if (celdasCambiadasEnEstaVersion != [NSNull null]){
        [self refrescarCanvasConCeldasCambiadas:celdasCambiadasEnEstaVersion
                             usarVersionAntigua:TRUE];
    }
}

- (IBAction)avanzarVersion:(UIButton *)sender {
    
    NSArray * celdasCambiadasEnEstaVersion = [[IRGAlmacenDeCambios sharedAlmacenDeCambios] versionSiguiente];
    if (celdasCambiadasEnEstaVersion != [NSNull null]){
        [self refrescarCanvasConCeldasCambiadas:celdasCambiadasEnEstaVersion
                             usarVersionAntigua:false];
    }
}

#pragma mark - Propios

- (void) refrescarCanvasConCeldasCambiadas:(NSArray *)celdasCambiadasEnEstaVersion
                        usarVersionAntigua:(bool) usarVersionAntigua{
    
    NSArray * todasLasCeldas = [[IRGAlmacenDeCeldas sharedAlmacenDeCeldas] allItems];
    
    IRGCeldaViewController * celdaViewController;
    
    for (IRGCeldaAlmacenada * celdaAlmacenada in celdasCambiadasEnEstaVersion){

        celdaViewController = [todasLasCeldas objectAtIndex: celdaAlmacenada.numeroDeCelda];
        
        UIColor * colorDelTrazo ;
        UIColor * colorDelRelleno ;
        NSUInteger grosorDelTrazo;

        if (usarVersionAntigua){
            colorDelTrazo= celdaAlmacenada.colorDelTrazoAntiguo;
            colorDelRelleno = celdaAlmacenada.colorDelRellenoAntiguo;
            grosorDelTrazo = celdaAlmacenada.grosorDelTrazoAntiguo;
        }
        else {
            colorDelTrazo= celdaAlmacenada.colorDelTrazoNuevo;
            colorDelRelleno = celdaAlmacenada.colorDelRellenoNuevo;
            grosorDelTrazo = celdaAlmacenada.grosorDelTrazoNuevo;
        }
        [celdaViewController actualizarViewControllerYDibujaCeldaConColorDelTrazoDeLaCelda:colorDelTrazo
                                                                  colorDelRellenoDeLaCelda:colorDelRelleno grosorDelPincelDeLaCElda:grosorDelTrazo];
    }
}


@end

