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
#pragma mark - Inicializadores

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
    self = [super initWithNibName:nil bundle:nil];
    if (self){
        _posicionX = posicionX;
        _posicionY = posicionY;
        _numeroDeCelda = numeroDeCelda;
        _alto = alto;
        _ancho = ancho;
    }
    return self;
}

#pragma mark Overrides

- (void)viewDidLoad {
    [super viewDidLoad];
    
    CGRect frame = CGRectMake(self.posicionX, self.posicionY, self.ancho , self.alto);
    UIColor *colorDelTrazo;
    NSUInteger grosorDelTrazo;
    
    if ([IRGLienzo sharedLienzo].dibujarBorderDeLaCelda){
        colorDelTrazo = [IRGLienzo sharedLienzo].colorDelTrazoDeLaCeldaSinPintar;
        grosorDelTrazo= [IRGLienzo sharedLienzo].grosoDelTrazoDeLaCeldaSinPintar;
    }
    else{
        colorDelTrazo = [UIColor clearColor];
        grosorDelTrazo = 0;
    }

    UIColor *colorDeRelleno = [IRGLienzo sharedLienzo].colorDelRellenoDeLaCeldaSinPintar;
    
    
    IRGCelda *celdaView = [[IRGCelda alloc]
                           initWithFrame:frame colorDelBorde:colorDelTrazo
                           grosorDelTrazo:grosorDelTrazo];
    
    celdaView.backgroundColor = colorDeRelleno;
    celdaView.delegado = self;
    
    self.view = celdaView;
    self.colorDelTrazoDeLaCelda = colorDelTrazo;;
    self.colorDelRellenoDeLaCelda = colorDeRelleno;
    self.grosorDelTrazoDeLaCelda = grosorDelTrazo;
    _celda = celdaView;
}

#pragma mark - Propios


- (void) inicioDeTouch:(IRGCelda*)sender{

    self.conjuntoDeCeldasPintadas = [[NSMutableArray alloc] init];

    if ([[IRGPincel sharedPincel].modoPincel isEqual:@"Pintar"]) {
        [self celdaPulsadaConModoPintar];
    }
    else {
        if ([[IRGPincel sharedPincel].modoPincel isEqual:@"RellenarNormal"]){
            [self celdaPulsadaConModoRellenarNormal];
          }
        else {
            if ([[IRGPincel sharedPincel].modoPincel isEqual:@"Borrar"]){
                [self celdaPulsadaConModoPintar];
                
            }
            else {
                [self celdaPulsadaConModoRellenarExtendido];
            }
        }
    }

}

- (void) movimientoDuranteTouch:(IRGCelda *)sender
                        posicionX:(int)posicionX
                        posicionY:(int)posicionY{
    if (([[IRGPincel sharedPincel].modoPincel  isEqual: @"Pintar"]) | ([[IRGPincel sharedPincel].modoPincel isEqual:@"Borrar"])){
        NSUInteger numeroDeCeldaRelativa = [[IRGAlmacenDeCeldas sharedAlmacenDeCeldas] celdaDePosicionX:posicionX posicionY:posicionY];
        NSUInteger numeroDeCelda = numeroDeCeldaRelativa+self.numeroDeCelda;
        NSArray * todasLasCeldas = [[IRGAlmacenDeCeldas sharedAlmacenDeCeldas]allItems];
        IRGCeldaViewController * celdaAfectadaViewController = todasLasCeldas[numeroDeCelda];
        [self pintarYGuardarCeldaDelViewController:celdaAfectadaViewController ];
    }
    
}

- (void) finDeTouch:(IRGCelda *)sender{
    [[IRGAlmacenDeCambios sharedAlmacenDeCambios] nuevaVersionConCeldas:self.conjuntoDeCeldasPintadas];
    [[IRGAlmacenDeCambios sharedAlmacenDeCambios] grabarCambios];
}

- (void) celdaPulsadaConModoBorrar{
    [self borrarYGuardarCeldaDelViewController:self];
}

- (void) celdaPulsadaConModoPintar{

    [self pintarYGuardarCeldaDelViewController:self];
}


- (void) celdaPulsadaConModoRellenarExtendido{
    
    NSArray *todosLosViewControllerDeLasCeldas =[[IRGAlmacenDeCeldas sharedAlmacenDeCeldas] allItems];
    UIColor *colorCeldaElegida = self.colorDelRellenoDeLaCelda;
    
    for (IRGCeldaViewController *celdaViewController in todosLosViewControllerDeLasCeldas ){
        if ([celdaViewController.colorDelRellenoDeLaCelda isEqual: colorCeldaElegida]){
            [self pintarYGuardarCeldaDelViewController:celdaViewController];
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
        
        [self pintarYGuardarCeldaDelViewController:celdaViewController];
        
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

-(void) borrarYGuardarCeldaDelViewController:(IRGCeldaViewController *) celdaViewController{
    
    UIColor * colorDeTrazoAntiguo = celdaViewController.colorDelTrazoDeLaCelda;
    UIColor * colorDeRellenoAntguo =  celdaViewController.colorDelRellenoDeLaCelda;
    NSUInteger grosorDelTrazoAntiguo = celdaViewController.grosorDelTrazoDeLaCelda;
    
    [celdaViewController borrarCeldaConLienzo];
    
    IRGCeldaAlmacenada * celdaPintada =[[IRGCeldaAlmacenada alloc]
                                        initWithCeldaAlmacenada:celdaViewController.numeroDeCelda
                                        colorDelRellenoAntiguo:colorDeRellenoAntguo
                                        colorDelRellenoNuevo:celdaViewController.colorDelRellenoDeLaCelda
                                        colorDelTrazoAntiguo:colorDeTrazoAntiguo
                                        colorDelTrazoNuevo:celdaViewController.colorDelTrazoDeLaCelda
                                        grosorDelTrazoAntiguo:grosorDelTrazoAntiguo
                                        grosorDelTrazoNuevo:celdaViewController.grosorDelTrazoDeLaCelda];
    
    [self.conjuntoDeCeldasPintadas addObject:celdaPintada];
}


-(void) pintarYGuardarCeldaDelViewController:(IRGCeldaViewController *) celdaViewController{
    
    UIColor * colorDeTrazoAntiguo = celdaViewController.colorDelTrazoDeLaCelda;
    UIColor * colorDeRellenoAntguo =  celdaViewController.colorDelRellenoDeLaCelda;
    NSUInteger grosorDelTrazoAntiguo = celdaViewController.grosorDelTrazoDeLaCelda;

    [celdaViewController dibujaCeldaConPincel];
    
    IRGCeldaAlmacenada * celdaPintada =[[IRGCeldaAlmacenada alloc]
                                        initWithCeldaAlmacenada:celdaViewController.numeroDeCelda
                                        colorDelRellenoAntiguo:colorDeRellenoAntguo
                                        colorDelRellenoNuevo:celdaViewController.colorDelRellenoDeLaCelda
                                        colorDelTrazoAntiguo:colorDeTrazoAntiguo
                                        colorDelTrazoNuevo:celdaViewController.colorDelTrazoDeLaCelda
                                        grosorDelTrazoAntiguo:grosorDelTrazoAntiguo
                                        grosorDelTrazoNuevo:celdaViewController.grosorDelTrazoDeLaCelda];
    
    bool grabarCeldaAlmacenada = YES;
    for (IRGCeldaViewController *celdaViewController in self.conjuntoDeCeldasPintadas){
        if (celdaViewController.numeroDeCelda == celdaPintada.numeroDeCelda){
            grabarCeldaAlmacenada = NO;
        }
    }
    if (grabarCeldaAlmacenada){
        [self.conjuntoDeCeldasPintadas addObject:celdaPintada];
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


- (void) dibujarCeldaConCeldaAlmacenadaConVersionAntigua:(IRGCeldaAlmacenada *)celdaAlmacenada
{
    self.colorDelRellenoDeLaCelda = celdaAlmacenada.colorDelRellenoAntiguo;
    self.colorDelTrazoDeLaCelda = celdaAlmacenada.colorDelTrazoAntiguo;
    self.grosorDelTrazoDeLaCelda = celdaAlmacenada.grosorDelTrazoAntiguo;
    [self dibujarCeldaConViewController];
}

- (void) dibujarCeldaConCeldaAlmacenadaConVersionNueva:(IRGCeldaAlmacenada *)celdaAlmacenada
{
    self.colorDelRellenoDeLaCelda = celdaAlmacenada.colorDelRellenoNuevo;
    self.colorDelTrazoDeLaCelda = celdaAlmacenada.colorDelTrazoNuevo;
    self.grosorDelTrazoDeLaCelda = celdaAlmacenada.grosorDelTrazoNuevo;
    [self dibujarCeldaConViewController];
}

- (void) borrarCeldaConLienzo
{
    self.colorDelTrazoDeLaCelda = [IRGLienzo sharedLienzo].colorDelTrazoDeLaCeldaSinPintar;
    self.grosorDelTrazoDeLaCelda = [IRGLienzo sharedLienzo].grosoDelTrazoDeLaCeldaSinPintar;
    self.colorDelRellenoDeLaCelda = [IRGLienzo sharedLienzo].colorDelRellenoDeLaCeldaSinPintar;
    [self dibujarCeldaConViewController];
}

- (void) dibujarCeldaConViewController {
    if ([IRGLienzo sharedLienzo].dibujarBorderDeLaCelda){
        self.celda.colorDelBorde = self.colorDelTrazoDeLaCelda;
        self.celda.grosorDelTrazoDeLaCelda = self.grosorDelTrazoDeLaCelda;
    }
    else {
        self.celda.colorDelBorde = self.colorDelTrazoDeLaCelda;
        self.celda.grosorDelTrazoDeLaCelda = 0;
    }
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
