//
//  IRGCanvasViewController.m
//  IRGDibujar
//
//  Created by Ivan Rodriguez Gonzalez on 26/10/14.
//  Copyright (c) 2014 IvanRodriguez. All rights reserved.
//

#import "IRGCanvasViewController.h"
#import "IRGCeldaViewController.h"
#import "IRGAlmacenDeCeldas.h"
#import "IRGPincelRelleno.h"
#import "IRGAlmacenDeCambios.h"
#import "IRGCeldaAlmacenada.h"
#import "IRGElegirColorViewController.h"



@interface IRGCanvasViewController ()


@property (weak, nonatomic) IBOutlet UILabel *versionActual;

@property (weak, nonatomic) IBOutlet UILabel *totalVersiones;

- (IBAction)accionRellenar:(UIButton *)sender;

- (IBAction)accionPintar:(UIButton *)sender;

- (IBAction)retrocederVersion:(id)sender;

- (IBAction)avanzarVersion:(UIButton *)sender;

- (void) seleccionarColor;

@end

@implementation IRGCanvasViewController


#pragma mark Inicializadores

-(instancetype) initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil{
    
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        self.navigationItem.title = @"Dibujar";
        
        UIBarButtonItem * botonDerecho = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemAction
                                                                                       target:self
                                                                                       action:@selector(seleccionarColor)];
        self.navigationItem.rightBarButtonItem = botonDerecho;
            [IRGPincelRelleno sharedPincelRelleno].modoPintar = true;
    }
    return self;
}


#pragma mark Overrides

- (void) touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event{
    [self actualizaVersiones];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    int posicionX =0;
    int posicionY = 100;
    int ancho =10;
    int alto =10;
    
    for (int coordenadax = posicionX;coordenadax<self.view.frame.size.width;coordenadax += ancho){
        
        for (int coordenadaY = posicionY;coordenadaY<self.view.frame.size.height;coordenadaY+= alto){
            
        IRGCeldaViewController *celdaViewController = [[IRGCeldaViewController alloc] initWithPosicionX:coordenadax
                                                                                posicionY:coordenadaY
                                                                                    ancho:ancho
                                                                                    alto:alto];
        [[IRGAlmacenDeCeldas sharedAlmacenDeCeldas] añadirCelda:celdaViewController];
        [self.view addSubview:celdaViewController.view];
        }}
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

- (IBAction)accionRellenar:(id)sender {
    [IRGPincelRelleno sharedPincelRelleno].modoPintar = FALSE;
}

- (IBAction)accionPintar:(UIButton *)sender {
    [IRGPincelRelleno sharedPincelRelleno].modoPintar = true;
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
    [self refrescarCanvasConCeldasCambiadas:celdasCambiadasEnEstaVersion
                       usarVersionAntigua:false];
}


- (void) seleccionarColor{
    IRGElegirColorViewController *elegirColorViewController = [[IRGElegirColorViewController alloc]init];
    [self.navigationController pushViewController:elegirColorViewController animated:YES];
}
#pragma mark Propios

- (void) actualizaVersiones{
    self.versionActual.text =  [NSString stringWithFormat:@"%d",[[IRGAlmacenDeCambios sharedAlmacenDeCambios] versionActual]];
    self.totalVersiones.text = [NSString stringWithFormat:@"%d",[[IRGAlmacenDeCambios sharedAlmacenDeCambios] numeroDeVersiones] ];
}

- (void) refrescarCanvasConCeldasCambiadas:(NSArray *)celdasCambiadasEnEstaVersion usarVersionAntigua:(bool) usarVersionAntigua{
    for (IRGCeldaAlmacenada * celdaAlmacenada in celdasCambiadasEnEstaVersion){
        for (IRGCeldaViewController *celdaViewController in [[IRGAlmacenDeCeldas sharedAlmacenDeCeldas] allItems] ){
            if ([celdaViewController esIgual:celdaAlmacenada]){
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
        }
        
    }
    
    [self actualizaVersiones];
    
};


@end
