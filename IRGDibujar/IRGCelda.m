//
//  IRGCelda.m
//  IRGDibujar
//
//  Created by Ivan Rodriguez Gonzalez on 26/10/14.
//  Copyright (c) 2014 IvanRodriguez. All rights reserved.
//

#import "IRGCelda.h"

@interface IRGCelda ()


@property (nonatomic,readonly) float posicionX;
@property (nonatomic,readonly) float posicionY;


@end

@implementation IRGCelda

- (instancetype) initWithFrame:(CGRect)frame{
    return [self initWithFrame:frame
                 colorDelBorde:[UIColor redColor]
                grosorDelTrazo:1];
}


- (instancetype) initWithFrame:(CGRect)frame
                 colorDelBorde:(UIColor *)colorDelBorde
                grosorDelTrazo:(NSUInteger) grosorDelTrazo; {

    self = [super initWithFrame:frame];
    if (self){
        _colorDelBorde = colorDelBorde;
        _grosorDelTrazoDeLaCelda = grosorDelTrazo;
    }
    return self;
}

- (void) touchesBegan:(NSSet *)touches
            withEvent:(UIEvent *)event{
    [self.delegado inicioDeTouch:self];
}

- (void)touchesMoved:(NSSet *)touches
           withEvent:(UIEvent *)event
{
    UITouch *t = [touches anyObject];
    CGPoint location = [t locationInView:self];
    [self.delegado movimientoDuranteTouch:self posicionX:location.x posicionY:location.y];
}

- (void)touchesEnded:(NSSet *)touches
           withEvent:(UIEvent *)event
{
    [self.delegado finDeTouch:self];
}



// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code

    UIBezierPath *path = [UIBezierPath bezierPathWithRect:self.bounds ];
    [self.colorDelBorde setStroke];
    path.lineWidth = self.grosorDelTrazoDeLaCelda;
    [path stroke];
}

-(void) setColorDelBorde:(UIColor *)colorDelBorde{
    _colorDelBorde = colorDelBorde;
//    NSLog(@"%@",_colorDelBorde);
}

-(float) posicionX{
    return self.frame.origin.x;
}

-(float) posicionY{
    return self.frame.origin.y;
}



@end
