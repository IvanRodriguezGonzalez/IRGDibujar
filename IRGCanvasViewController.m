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
#import "IRGPincelRelleno.h"
#import "IRGAlmacenDeCambios.h"
#import "IRGCeldaAlmacenada.h"
#import "IRGElegirColorViewController.h"



@interface IRGCanvasViewController ()




@property (weak, nonatomic) IBOutlet UIView *barraDeIconos;

@property (weak, nonatomic) IBOutlet UIView *celdaPintar;
@property (weak, nonatomic) IBOutlet UIView *celdaRellenar;
@property (weak, nonatomic) IBOutlet UIView *colorElegido;

- (IBAction)establecerColor:(UIButton *)sender;

- (IBAction)accionRellenar:(UIButton *)sender;

- (IBAction)accionRellenarExtendido:(UIButton *)sender;

- (IBAction)accionPintar:(UIButton *)sender;


- (IBAction)retrocederVersion:(id)sender;

- (IBAction)avanzarVersion:(UIButton *)sender;

- (void) seleccionarColor;

@end

@implementation IRGCanvasViewController


#pragma mark - Inicializadores

-(instancetype) initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil{
    
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        
        [IRGPincelRelleno sharedPincelRelleno].modoPincel = @"Pintar";
        
        
        UIBarButtonItem * botonIzquierdo = [[UIBarButtonItem alloc]
                                             initWithBarButtonSystemItem:UIBarButtonSystemItemRewind
                                             target:self
                                             action:@selector(retrocederVersion:)];
    /*    UIBarButtonItem * botonDerechoUno =[[UIBarButtonItem alloc]
                                            initWithBarButtonSystemItem:UIBarButtonSystemItemBookmarks
                                            target:self
                                            action:@selector(seleccionarColor)];*/
        
        UIBarButtonItem * botonDerecho=[[UIBarButtonItem alloc]
                                            initWithBarButtonSystemItem:UIBarButtonSystemItemFastForward
                                            target:self
                                            action:@selector(avanzarVersion:)];
        
        
        NSArray *botonesDerechos = @[botonDerecho];
        self.navigationItem.rightBarButtonItems = botonesDerechos;
        self.navigationItem.leftBarButtonItem = botonIzquierdo;
        
        
   /*     for (UIBarButtonItem *item in self.navigationItem.rightBarButtonItems){
            [item setTintColor:[UIColor grayColor]];
        }*/
    }
    return self;
}


#pragma mark - Overrides

- (void) touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event{

}

- (void)viewDidLoad {
    [super viewDidLoad];
 
    self.view.frame = [[UIApplication sharedApplication] keyWindow].frame;
    NSUInteger posicionX;
    NSUInteger posicionY = 70;
    NSUInteger ancho =20;
    NSUInteger alto =20;
    
    NSUInteger numeroDeCelda;
    NSUInteger anchoBarraDeIconos = self.barraDeIconos.frame.size.width;
    NSUInteger anchoDeLaVentanaAjustado = self.view.frame.size.width;
    
    
    NSUInteger numeroDeCeldasEnCadaFila = (anchoDeLaVentanaAjustado - anchoBarraDeIconos) / ancho;
    NSUInteger bordeHorizontal = anchoDeLaVentanaAjustado - numeroDeCeldasEnCadaFila*ancho- anchoBarraDeIconos;
    
    posicionX = anchoBarraDeIconos + (bordeHorizontal/2);
    
    
    for (NSUInteger coordenadaY = posicionY;coordenadaY+alto<=self.view.frame.size.height;coordenadaY+= alto){
        for (NSUInteger coordenadax = posicionX;coordenadax+ancho<=anchoDeLaVentanaAjustado;coordenadax += ancho){
                
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
    IRGAlmacenDeCeldas * a = [IRGAlmacenDeCeldas sharedAlmacenDeCeldas];
    
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
      [IRGPincelRelleno sharedPincelRelleno].colorDelRelleno = sender.backgroundColor ;
    self.colorElegido.backgroundColor = sender.backgroundColor;
}

- (IBAction)accionRellenar:(id)sender {
    [IRGPincelRelleno sharedPincelRelleno].modoPincel = @"RellenarExtendido";
    [self.celdaPintar setBackgroundColor:self.barraDeIconos.backgroundColor];
    [self.celdaRellenar setBackgroundColor:[UIColor redColor]];
    
}

- (IBAction)accionRellenarExtendido:(UIButton *)sender {
    [IRGPincelRelleno sharedPincelRelleno].modoPincel = @"RellenarNormal";
    [self.celdaPintar setBackgroundColor:self.barraDeIconos.backgroundColor];
    [self.celdaRellenar setBackgroundColor: self.barraDeIconos.backgroundColor];
}

- (IBAction)accionPintar:(UIButton *)sender {
    [IRGPincelRelleno sharedPincelRelleno].modoPincel = @"Pintar";
    [self.celdaRellenar setBackgroundColor:self.barraDeIconos.backgroundColor];
    [self.celdaPintar setBackgroundColor:[UIColor redColor]];
    
    
}

- (IBAction)colorUno:(UIButton *)sender {
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

- (void) seleccionarColor{
    IRGElegirColorViewController *elegirColorViewController = [[IRGElegirColorViewController alloc]init];
    [self.navigationController pushViewController:elegirColorViewController animated:YES];
}
#pragma mark - Propios



- (void) refrescarCanvasConCeldasCambiadas:(NSArray *)celdasCambiadasEnEstaVersion usarVersionAntigua:(bool) usarVersionAntigua{
    
    NSArray * todasLasCeldas;
    IRGCeldaViewController * celdaViewController;
    
    for (IRGCeldaAlmacenada * celdaAlmacenada in celdasCambiadasEnEstaVersion){
       
        todasLasCeldas = [[IRGAlmacenDeCeldas sharedAlmacenDeCeldas] allItems] ;
        celdaViewController = [todasLasCeldas objectAtIndex: celdaAlmacenada.numeroDeCelda];
                               
        if (usarVersionAntigua){
            celdaViewController.rellenada = celdaAlmacenada.rellenadaAntigua;
            celdaViewController.celda.backgroundColor = celdaAlmacenada.colorDelRellenoAntiguo;
                    
        }
        else {
            celdaViewController.rellenada = celdaAlmacenada.rellenadaNueva;
            celdaViewController.celda.backgroundColor = celdaAlmacenada.colorDelRellenoNuevo;
        }
                
        [celdaViewController.celda setNeedsDisplay];
                
    }
};


@end

