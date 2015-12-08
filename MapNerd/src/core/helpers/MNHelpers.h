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
+ (int)calculateDistanceFrom:(CLLocation *)from to:(CLLocation *)to;

/**
 * Dibuja una línea (MKPolyline) entre dos puntos.
 *
 * @param from Origin value of the interval.
 * @param to Destination value of the interval.
 */
+ (MKPolyline *)drawLineFrom:(CLLocation *)from to:(CLLocation *)to;

#pragma mark - Annotation methods

/**
 * Borra las anotaciones y los overlays anteriores del mapaMundo.
 */
+ (void)removeAnnotations:(MKMapView *)map;

/**
 * Muestra una anotación (MKPointAnnotation) en el mapaMundo.
 * Solo falta añadirla al mapa con: [_mapa addAnnotation:anotation];
 *
 * @param coordinates Coordinate of the annotation.
 * @param title Title of the annotation.
 * @param subtitle Subtitle of the annotation.
 */
+ (MKPointAnnotation *)showAnnotaton:(CLLocationCoordinate2D)coordinates title:(NSString *)title subtitle:(NSString *)subtitle;

@end
