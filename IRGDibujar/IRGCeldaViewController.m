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


@interface IRGCeldaViewController ()

@property (nonatomic) NSUInteger posicionX;
@property (nonatomic) NSUInteger posicionY;
@property (nonatomic) NSUInteger alto;
@property (nonatomic) NSUInteger ancho;
@property (nonatomic) UIColor *colorDelBordeDeLaCelda;
@property (nonatomic)BOOL rellenada;

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
}

- (void) celdaPulsada:(IRGCelda*)sender{
    
    if ([IRGPincelRelleno sharedPincelRelleno].modoPintar){
        if(self.rellenada){
            UIColor *colorDelBordeDelPincelNormal = [IRGPincelNormal sharedPincelNormal].colorDelBorde;
            UIColor *colorDeRellenoDelPincelNormal = [IRGPincelNormal sharedPincelNormal].colorDelRelleno;
            [sender setColorDelBorde:colorDelBordeDelPincelNormal];
            self.view.backgroundColor = colorDeRellenoDelPincelNormal;
            self.rellenada = FALSE;
        }
        else {
            UIColor *colorDelBordeDelPincelRelleno = [IRGPincelRelleno sharedPincelRelleno].colorDelBorde;
            UIColor *colorDeRellenoDelPincelRelleno = [IRGPincelRelleno sharedPincelRelleno].colorDelRelleno;
        
            [sender setColorDelBorde:colorDelBordeDelPincelRelleno];
            self.view.backgroundColor = colorDeRellenoDelPincelRelleno ;
            self.rellenada = TRUE;
        }
    } else {
        //estoy en modo rellenar
        NSArray *todasLasCeldas =[[IRGAlmacenDeCeldas sharedAlmacenDeCeldas] allItems];
        UIColor *colorCeldaElegida = self.view.backgroundColor;
            for (IRGCelda *celdaTmp in todasLasCeldas ){
                if (celdaTmp.backgroundColor == colorCeldaElegida){
                    celdaTmp.backgroundColor = [IRGPincelRelleno sharedPincelRelleno].colorDelRelleno;
               //     celdaTmp.delegado.rellenada = true;
                    [celdaTmp setNeedsDisplay];
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

@end
