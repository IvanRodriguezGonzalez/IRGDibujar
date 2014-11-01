//
//  IRGCeldaViewController.m
//  IRGDibujar
//
//  Created by Ivan Rodriguez Gonzalez on 26/10/14.
//  Copyright (c) 2014 IvanRodriguez. All rights reserved.
//

#import "IRGCeldaViewController.h"
#import "IRGCelda.h"
#import "IRGPincelNormal.h"
#import "IRGPincelRelleno.h"
#import "IRGAlmacenDeCeldas.h"
#import "IRGAlmacenDeCambios.h"
#import "IRGCeldaAlmacenada.h"


@interface IRGCeldaViewController ()
;

@property (nonatomic) NSUInteger posicionX;
@property (nonatomic) NSUInteger posicionY;
@property (nonatomic) NSUInteger alto;
@property (nonatomic) NSUInteger ancho;
@property (nonatomic) UIColor *colorDelBordeDeLaCelda;
@property (nonatomic) NSMutableArray * conjuntoDeCeldasPintadas;


@end

@implementation IRGCeldaViewController

-(instancetype)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil{
    [NSException exceptionWithName:@"Invalid init" reason:@"Use..." userInfo:nil];
    return FALSE;
}

//designated initializer
-(instancetype) initWithPosicionX:(NSUInteger)posicionX
                        posicionY:(NSUInteger)posicionY
                    numeroDeCelda:(NSUInteger)numeroDeCelda
                            ancho:(NSUInteger)ancho
                             alto:(NSUInteger)alto{
    _posicionX = posicionX;
    _posicionY = posicionY;
    _numeroDeCelda = numeroDeCelda;
    _alto = alto;
    _ancho = ancho;
    return self;
}


#pragma mark Accesors

-(void) setRellenada:(BOOL)rellenada{
    _rellenada = rellenada;
    if (rellenada) {
        UIColor *colorDelBordeDelPincelRelleno = [IRGPincelRelleno sharedPincelRelleno].colorDelBorde;
        UIColor *colorDeRellenoDelPincelRelleno = [IRGPincelRelleno sharedPincelRelleno].colorDelRelleno;
        [self.celda setColorDelBorde:colorDelBordeDelPincelRelleno];
        self.celda.backgroundColor = colorDeRellenoDelPincelRelleno ;
        
    }
    else {
        UIColor *colorDelBordeDelPincelNormal = [IRGPincelNormal sharedPincelNormal].colorDelBorde;
        UIColor *colorDeRellenoDelPincelNormal = [IRGPincelNormal sharedPincelNormal].colorDelRelleno;
        [self.celda setColorDelBorde:colorDelBordeDelPincelNormal];
        self.celda.backgroundColor = colorDeRellenoDelPincelNormal;
    }
    [self.celda setNeedsDisplay ];
}

#pragma mark Overrides

- (void)viewDidLoad {
    [super viewDidLoad];
    CGRect frame = CGRectMake(self.posicionX, self.posicionY, self.ancho , self.alto);
    
    UIColor *colorDelBordeDelPincelNormal = [IRGPincelNormal sharedPincelNormal].colorDelBorde;
    UIColor *colorDeRellenoDelPincelNormal = [IRGPincelNormal sharedPincelNormal].colorDelRelleno;
 
    IRGCelda *view = [[IRGCelda alloc] initWithFrame:frame colorDelBorde:colorDelBordeDelPincelNormal];
    view.backgroundColor = colorDeRellenoDelPincelNormal;
    
    self.colorDelBordeDeLaCelda = view.colorDelBorde;
    self.rellenada = FALSE;
    
    view.delegado = self;
    self.view = view;
    _celda = view;
}

- (void) celdaPulsada:(IRGCelda*)sender{

    self.conjuntoDeCeldasPintadas = [[NSMutableArray alloc] init];

    if ([[IRGPincelRelleno sharedPincelRelleno].modoPincel isEqual:@"Pintar"]){
    
        UIColor * colorDelRellenoAntiguo = self.celda.backgroundColor;
        bool rellenadaAntigua = self.rellenada;
        self.rellenada = ! self.rellenada;
        IRGCeldaAlmacenada * celdaPintada =[[IRGCeldaAlmacenada alloc]
                                            initWithCeldaAlmacenada:self.numeroDeCelda
                                            colorDelRellenoAntiguo:colorDelRellenoAntiguo
                                            colorDelRellenoNuevo:self.celda.backgroundColor
                                            rellenadaAntigua:rellenadaAntigua
                                            rellenadaNueva:self.rellenada];
        [self.conjuntoDeCeldasPintadas addObject:celdaPintada];
        [[IRGAlmacenDeCambios sharedAlmacenDeCambios] nuevaVersionConCeldas:self.conjuntoDeCeldasPintadas];
    }
    else {
        if ([[IRGPincelRelleno sharedPincelRelleno].modoPincel isEqual:@"RellenarNormal"]){
            NSArray *todasLosViewControllerDeLasCeldas =[[IRGAlmacenDeCeldas sharedAlmacenDeCeldas] allItems];
            UIColor *colorCeldaElegida = self.celda.backgroundColor;
   
            for (IRGCeldaViewController *celdaViewController in todasLosViewControllerDeLasCeldas ){
                if ([celdaViewController.celda.backgroundColor isEqual: colorCeldaElegida]){

                    bool rellenadaAntigua =celdaViewController.rellenada;
                    celdaViewController.rellenada = true;
                    IRGCeldaAlmacenada * celdaPintada =[[IRGCeldaAlmacenada alloc]
                                                        initWithCeldaAlmacenada:celdaViewController.numeroDeCelda
                                                        colorDelRellenoAntiguo:colorCeldaElegida
                                                        colorDelRellenoNuevo:celdaViewController.celda.backgroundColor
                                                        rellenadaAntigua:rellenadaAntigua
                                                        rellenadaNueva:celdaViewController.rellenada];
                    [self.conjuntoDeCeldasPintadas addObject:celdaPintada];
                }
            }
            [[IRGAlmacenDeCambios sharedAlmacenDeCambios] nuevaVersionConCeldas:self.conjuntoDeCeldasPintadas];
        }
        else {
            UIColor * colorAntiguo = self.celda.backgroundColor;
            if ([self.celda.backgroundColor isEqual:[IRGPincelRelleno sharedPincelRelleno].colorDelRelleno]){
                }
            else {
                [self colorearCeldaViewController:self
                                  conColorAntiguo:colorAntiguo];
                [[IRGAlmacenDeCambios sharedAlmacenDeCambios] nuevaVersionConCeldas:self.conjuntoDeCeldasPintadas];
            }
        }

    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/


#pragma mark Propios

- (BOOL)esIgual:(IRGCeldaAlmacenada *)celdaAlmacenada{
    if (self.numeroDeCelda == celdaAlmacenada.numeroDeCelda){
        return TRUE;
    }
    else {
        return FALSE;
    }
}

- (void) colorearCeldaViewController:(IRGCeldaViewController *) celdaViewController
conColorAntiguo: (UIColor *)colorAntiguo {
    
    if ([celdaViewController.celda.backgroundColor isEqual:colorAntiguo]){
        
        bool rellenadaAntigua =celdaViewController.rellenada;

       // celdaViewController.celda.backgroundColor = colorNuevo;
     //
        
    celdaViewController.rellenada = true;
        
        IRGCeldaAlmacenada * celdaPintada =[[IRGCeldaAlmacenada alloc]
                                            initWithCeldaAlmacenada:celdaViewController.numeroDeCelda
                                            colorDelRellenoAntiguo:colorAntiguo
                                            colorDelRellenoNuevo:celdaViewController.celda.backgroundColor
                                            rellenadaAntigua:rellenadaAntigua
                                            rellenadaNueva:celdaViewController.rellenada];


        
        [self.conjuntoDeCeldasPintadas addObject:celdaPintada];
 
         IRGCeldaViewController *siguienteCeldaEnLaFila = [[IRGAlmacenDeCeldas sharedAlmacenDeCeldas] siguienteCeldaEnLaFila:celdaViewController];
        if (siguienteCeldaEnLaFila){
            [self colorearCeldaViewController:siguienteCeldaEnLaFila conColorAntiguo:colorAntiguo];
        }
        
        IRGCeldaViewController *anteriorCeldaEnLaFila = [[IRGAlmacenDeCeldas sharedAlmacenDeCeldas] anteriorCeldaEnLaFila:celdaViewController];
        if (anteriorCeldaEnLaFila){
            [self colorearCeldaViewController:anteriorCeldaEnLaFila conColorAntiguo:colorAntiguo];
        }
        
        IRGCeldaViewController *celdaEnLaFilaSuperior = [[IRGAlmacenDeCeldas sharedAlmacenDeCeldas] celdaEnLaFilaSuperior:celdaViewController];
        if (celdaEnLaFilaSuperior){
            [self colorearCeldaViewController:celdaEnLaFilaSuperior conColorAntiguo:colorAntiguo];
        }
        
        IRGCeldaViewController *celdaEnLaFilaInferior = [[IRGAlmacenDeCeldas sharedAlmacenDeCeldas] celdaEnLaFilaInferior:celdaViewController];
        if (celdaEnLaFilaInferior){
            [self colorearCeldaViewController:celdaEnLaFilaInferior conColorAntiguo:colorAntiguo];
        }
    }
}

@end
