//
//  IRGCeldaViewController.m
//  IRGDibujar
//
//  Created by Ivan Rodriguez Gonzalez on 26/10/14.
//  Copyright (c) 2014 IvanRodriguez. All rights reserved.
//

#import "IRGCeldaViewController.h"
#import "IRGCelda.h"
#import "IRGAlmacenDeCeldas.h"
#import "IRGAlmacenDeCambios.h"
#import "IRGCeldaAlmacenada.h"

#import "IRGPincel.h"
#import "IRGLienzo.h"

@interface IRGCeldaViewController ()
;

@property (nonatomic) NSUInteger posicionX;
@property (nonatomic) NSUInteger posicionY;
@property (nonatomic) NSUInteger alto;
@property (nonatomic) NSUInteger ancho;
@property (nonatomic) UIColor *colorDelTrazoDeLaCelda;
@property (nonatomic) UIColor *colorDelRellenoDeLaCelda;
@property (nonatomic) NSUInteger grosorDelTrazoDeLaCelda;

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




#pragma mark Overrides

- (void)viewDidLoad {
    [super viewDidLoad];
    
    CGRect frame = CGRectMake(self.posicionX, self.posicionY, self.ancho , self.alto);
    
    UIColor *colorDelTrazo = [IRGLienzo sharedLienzo].colorDelTrazoDeLaCeldaSinPintar;
    UIColor *colorDeRelleno = [IRGLienzo sharedLienzo].colorDelRellenoDeLaCeldaSinPintar;
    NSUInteger grosordelTrazo = [IRGLienzo sharedLienzo].grosoDelTrazoDeLaCeldaSinPintar;
    
    
    IRGCelda *celdaView = [[IRGCelda alloc]
                           initWithFrame:frame colorDelBorde:colorDelTrazo
                           grosorDelTrazo:grosordelTrazo];
    
    celdaView.backgroundColor = colorDeRelleno;
    celdaView.delegado = self;
    
    self.view = celdaView;
    self.colorDelTrazoDeLaCelda = colorDelTrazo;;
    self.colorDelRellenoDeLaCelda = colorDeRelleno;
    self.grosorDelTrazoDeLaCelda = grosordelTrazo;
    _celda = celdaView;
}

- (void) celdaPulsada:(IRGCelda*)sender{

    self.conjuntoDeCeldasPintadas = [[NSMutableArray alloc] init];

    if ([[IRGPincel sharedPincel].modoPincel isEqual:@"Pintar"]){
        [self celdaPulsadaConModoPintar];
    }
    else {
        if ([[IRGPincel sharedPincel].modoPincel isEqual:@"RellenarNormal"]){
            [self celdaPulsadaConModoRellenarNormal];
          }
        else {
            [self celdaPulsadaConModoRellenarExtendido];
        }
    }
    [[IRGAlmacenDeCambios sharedAlmacenDeCambios] nuevaVersionConCeldas:self.conjuntoDeCeldasPintadas];
}


- (void) celdaPulsadaConModoPintar{

    UIColor * colorDeTrazoDelPincel = [IRGPincel sharedPincel].colorDeTrazoDelPincel;
    UIColor * colorDeRellenoDelPincel = [IRGPincel sharedPincel].colorDeRellenoDelPincel;
    NSUInteger grosorDelTrazoDelPincel = [IRGPincel sharedPincel].grosorDelTrazoDelPincel;
    
    UIColor * colorDeTrazoAntiguo = self.colorDelTrazoDeLaCelda;
    UIColor * colorDeRellenoAntguo =  self.colorDelRellenoDeLaCelda;
    NSUInteger grosorDelTrazoAntiguo = self.grosorDelTrazoDeLaCelda;
    
    IRGCeldaAlmacenada * celdaPintada =[[IRGCeldaAlmacenada alloc]
                                        initWithCeldaAlmacenada:self.numeroDeCelda
                                        colorDelRellenoAntiguo:colorDeRellenoAntguo
                                        colorDelRellenoNuevo:colorDeRellenoDelPincel
                                        colorDelTrazoAntiguo:colorDeTrazoAntiguo
                                        colorDelTrazoNuevo:colorDeTrazoDelPincel
                                        grosorDelTrazoAntiguo:grosorDelTrazoAntiguo
                                        grosorDelTrazoNuevo:grosorDelTrazoDelPincel];
                                        
    [self dibujaCeldaConPincel];
    [self.conjuntoDeCeldasPintadas addObject:celdaPintada];
    
}


- (void) celdaPulsadaConModoRellenarExtendido{
    
    NSArray *todosLosViewControllerDeLasCeldas =[[IRGAlmacenDeCeldas sharedAlmacenDeCeldas] allItems];
    
    UIColor *colorCeldaElegida = self.colorDelRellenoDeLaCelda;
    
    for (IRGCeldaViewController *celdaViewController in todosLosViewControllerDeLasCeldas ){
        if ([celdaViewController.colorDelRellenoDeLaCelda isEqual: colorCeldaElegida]){
            
            UIColor * colorDeTrazoDelPincel = [IRGPincel sharedPincel].colorDeTrazoDelPincel;
            UIColor * colorDeRellenoDelPincel = [IRGPincel sharedPincel].colorDeRellenoDelPincel;
            NSUInteger grosorDelTrazoDelPincel = [IRGPincel sharedPincel].grosorDelTrazoDelPincel;
            
            UIColor * colorDeTrazoAntiguo = celdaViewController.colorDelTrazoDeLaCelda;
            UIColor * colorDeRellenoAntguo =  celdaViewController.colorDelRellenoDeLaCelda;
            NSUInteger grosorDelTrazoAntiguo = celdaViewController.grosorDelTrazoDeLaCelda;
            
            
            IRGCeldaAlmacenada * celdaPintada =[[IRGCeldaAlmacenada alloc]
                                                initWithCeldaAlmacenada:celdaViewController.numeroDeCelda
                                                colorDelRellenoAntiguo:colorDeRellenoAntguo
                                                colorDelRellenoNuevo:colorDeRellenoDelPincel
                                                colorDelTrazoAntiguo:colorDeTrazoAntiguo
                                                colorDelTrazoNuevo:colorDeTrazoDelPincel
                                                grosorDelTrazoAntiguo:grosorDelTrazoAntiguo
                                                grosorDelTrazoNuevo:grosorDelTrazoDelPincel];
           
            [celdaViewController dibujaCeldaConPincel];
            [self.conjuntoDeCeldasPintadas addObject:celdaPintada];
        }
    }
}

- (void) celdaPulsadaConModoRellenarNormal{
    
    UIColor * colorAntiguo = self.colorDelRellenoDeLaCelda;
    
    if (![colorAntiguo isEqual:[IRGPincel sharedPincel].colorDeRellenoDelPincel]){
        [self colorearNormalCeldaViewController:self
                          conColorAntiguo:colorAntiguo];
    };
    
    
}



- (void) colorearNormalCeldaViewController:(IRGCeldaViewController *) celdaViewController
                           conColorAntiguo: (UIColor *)colorAntiguo {
    
    if ([celdaViewController.colorDelRellenoDeLaCelda isEqual:colorAntiguo]){
        
        UIColor * colorDeTrazoDelPincel = [IRGPincel sharedPincel].colorDeTrazoDelPincel;
        UIColor * colorDeRellenoDelPincel = [IRGPincel sharedPincel].colorDeRellenoDelPincel;
        NSUInteger grosorDelTrazoDelPincel = [IRGPincel sharedPincel].grosorDelTrazoDelPincel;
        
        UIColor * colorDeTrazoAntiguo = celdaViewController.colorDelTrazoDeLaCelda;
        UIColor * colorDeRellenoAntguo =  celdaViewController.colorDelRellenoDeLaCelda;
        NSUInteger grosorDelTrazoAntiguo = celdaViewController.grosorDelTrazoDeLaCelda;
        
        
        IRGCeldaAlmacenada * celdaPintada =[[IRGCeldaAlmacenada alloc]
                                            initWithCeldaAlmacenada:celdaViewController.numeroDeCelda
                                            colorDelRellenoAntiguo:colorDeRellenoAntguo
                                            colorDelRellenoNuevo:colorDeRellenoDelPincel
                                            colorDelTrazoAntiguo:colorDeTrazoAntiguo
                                            colorDelTrazoNuevo:colorDeTrazoDelPincel
                                            grosorDelTrazoAntiguo:grosorDelTrazoAntiguo
                                            grosorDelTrazoNuevo:grosorDelTrazoDelPincel];
        
        [celdaViewController dibujaCeldaConPincel];
        [self.conjuntoDeCeldasPintadas addObject:celdaPintada];
        
        IRGCeldaViewController *siguienteCeldaEnLaFila = [[IRGAlmacenDeCeldas sharedAlmacenDeCeldas] siguienteCeldaEnLaFila:celdaViewController];
        if (siguienteCeldaEnLaFila){
            [self colorearNormalCeldaViewController:siguienteCeldaEnLaFila conColorAntiguo:colorAntiguo];
        }
        
        IRGCeldaViewController *anteriorCeldaEnLaFila = [[IRGAlmacenDeCeldas sharedAlmacenDeCeldas] anteriorCeldaEnLaFila:celdaViewController];
        if (anteriorCeldaEnLaFila){
            [self colorearNormalCeldaViewController:anteriorCeldaEnLaFila conColorAntiguo:colorAntiguo];
        }
        
        IRGCeldaViewController *celdaEnLaFilaSuperior = [[IRGAlmacenDeCeldas sharedAlmacenDeCeldas] celdaEnLaFilaSuperior:celdaViewController];
        if (celdaEnLaFilaSuperior){
            [self colorearNormalCeldaViewController:celdaEnLaFilaSuperior conColorAntiguo:colorAntiguo];
        }
        
        IRGCeldaViewController *celdaEnLaFilaInferior = [[IRGAlmacenDeCeldas sharedAlmacenDeCeldas] celdaEnLaFilaInferior:celdaViewController];
        if (celdaEnLaFilaInferior){
            [self colorearNormalCeldaViewController:celdaEnLaFilaInferior conColorAntiguo:colorAntiguo];
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



-(void) dibujaCeldaConPincel{
    [self actualizarViewControllerConPincel];
    [self dibujarCeldaConViewController];
    
}

- (void) actualizarViewControllerConPincel{
    self.colorDelRellenoDeLaCelda = [IRGPincel sharedPincel].colorDeRellenoDelPincel;
    self.colorDelTrazoDeLaCelda = [IRGPincel sharedPincel].colorDeTrazoDelPincel;
    self.grosorDelTrazoDeLaCelda = [IRGPincel sharedPincel].grosorDelTrazoDelPincel;
}

- (void) dibujarCeldaConViewController {
    
    self.celda.colorDelBorde = self.colorDelTrazoDeLaCelda;
    self.celda.grosorDelTrazoDeLaCelda = self.grosorDelTrazoDeLaCelda;
    self.celda.backgroundColor = self.colorDelRellenoDeLaCelda;
    [self.celda setNeedsDisplay];
}

- (void) actualizarViewControllerYDibujaCeldaConColorDelTrazoDeLaCelda:(UIColor *) colorDelTrazoDeLaCelda
                                              colorDelRellenoDeLaCelda:(UIColor *) colorDelRellenoDeLaCelda
                                              grosorDelPincelDeLaCElda:(NSUInteger) grosorDelPincelDeLaCelda {
    self.colorDelTrazoDeLaCelda = colorDelTrazoDeLaCelda;
    self.colorDelRellenoDeLaCelda = colorDelRellenoDeLaCelda;
    self.grosorDelTrazoDeLaCelda = grosorDelPincelDeLaCelda;
    [self dibujarCeldaConViewController];
}


@end
