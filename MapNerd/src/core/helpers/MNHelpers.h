//
//  MNHelpers.h
//  MapNerd
//
//  Created by Jose Manuel Ramírez Martínez on 06/12/15.
//  Copyright © 2015 Jose Manuel Ramírez Martínez. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <MapKit/MapKit.h>

@interface MNHelpers : NSObject

#pragma mark - Helper methods

/**
 * Nos devuelve un número aleatorio entre dos valores.
 *
 * @param from From value of the interval.
 * @param to to Value of the interval.
 *
 * @return Random number.
 */
+ (int)getRandomNumberBetween:(int)from to:(int)to;

/**
 * Nos retorna la distancia en kilometros entre dos puntos.
 * Además, iremos acumulando las distancias calculadas durante la partida en la etiquetaDistancia.
 *
 * @param from Coordinate location for the origin value of the interval.
 * @param to Coordinate location for the destination value of the interval.
 *
 * @return distance in kilometers between the two points.
 */
+ (int)distance:(CLLocation *)from to:(CLLocation *)to;

/**
 * Dibuja una línea (MKPolyline) entre dos puntos.
 *
 * @param from Origin value of the interval.
 * @param to Destination value of the interval.
 */
+ (void)drawLineFrom:(CLLocationCoordinate2D)from to:(CLLocationCoordinate2D)to;

@end
