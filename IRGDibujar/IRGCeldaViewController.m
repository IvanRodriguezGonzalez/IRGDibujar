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

@property (nonatomic) NSUInteger posicionX;
@property (nonatomic) NSUInteger posicionY;
@property (nonatomic) NSUInteger alto;
@property (nonatomic) NSUInteger ancho;
@property (nonatomic) UIColor *colorDelBordeDeLaCelda;


@end

@implementation IRGCeldaViewController

-(instancetype)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil{
    return [self initWithPosicionX:0 posicionY:0 ancho:10 alto:10];
}

//designated initializer
-(instancetype) initWithPosicionX:(NSUInteger)posicionX
                        posicionY:(NSUInteger)posicionY
                            ancho:(NSUInteger)ancho
                             alto:(NSUInteger)alto{
    _posicionX = posicionX;
    _posicionY = posicionY;
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
    CGRect frame = CGRectMake(self.posicionX, self.posicionY, self.alto, self.ancho);
    
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
    

    NSMutableArray * conjuntoDeCeldasPintadas = [[NSMutableArray alloc] init];

    
    if ([IRGPincelRelleno sharedPincelRelleno].modoPintar){
        
        UIColor * colorDelRellenoAntiguo = self.celda.backgroundColor;
        bool rellenadaAntigua = self.rellenada;
        
        self.rellenada = ! self.rellenada;
      
        IRGCeldaAlmacenada * celdaPintada =[[IRGCeldaAlmacenada alloc] initWithCeldaAlmacenada:self.celda.frame
                                                                        colorDelRellenoAntiguo:colorDelRellenoAntiguo
                                                                          colorDelRellenoNuevo:self.celda.backgroundColor
                                                                              rellenadaAntigua:rellenadaAntigua
                                                                                rellenadaNueva:self.rellenada];
        [conjuntoDeCeldasPintadas addObject:celdaPintada];

        
    } else {
        //estoy en modo rellenar
        NSArray *todasLosViewControllerDeLasCeldas =[[IRGAlmacenDeCeldas sharedAlmacenDeCeldas] allItems];
        UIColor *colorCeldaElegida = self.view.backgroundColor;
   
        for (IRGCeldaViewController *celdaViewController in todasLosViewControllerDeLasCeldas ){
                if (celdaViewController.view.backgroundColor == colorCeldaElegida){

                    bool rellenadaAntigua =celdaViewController.rellenada;

                    celdaViewController.rellenada = true;

                    IRGCeldaAlmacenada * celdaPintada =[[IRGCeldaAlmacenada alloc] initWithCeldaAlmacenada:celdaViewController.celda.frame
                                                                                    colorDelRellenoAntiguo:colorCeldaElegida
                                                                                      colorDelRellenoNuevo:celdaViewController.celda.backgroundColor
                                                                                          rellenadaAntigua:rellenadaAntigua
                                                                                            rellenadaNueva:celdaViewController.rellenada];
                    [conjuntoDeCeldasPintadas addObject:celdaPintada];
                }
            }
    }
    [[IRGAlmacenDeCambios sharedAlmacenDeCambios] nuevaVersionConCeldas:conjuntoDeCeldasPintadas];

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
    if ((self.celda.frame.origin.x == celdaAlmacenada.frame.origin.x) & (self.celda.frame.origin.y == celdaAlmacenada.frame.origin.y)){
        return TRUE;
    }
    else {
        return FALSE;
    }
}

@end
