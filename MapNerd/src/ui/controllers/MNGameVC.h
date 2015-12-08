//
//  ViewController.h
//  BaseProject
//
//  Created by Jose Manuel Ramírez Martínez on 29/11/15.
//  Copyright © 2015 Jose Manuel Ramírez Martínez. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <MapKit/MapKit.h>

@interface MNGameVC : UIViewController <MKMapViewDelegate>

#pragma mark - Game methods

/**
 * Inicialización del juego y mostrar el primer mapa ciudad.
 */
- (void)initGame;

/**
 * Nos da una ciudad aleatoria del array de ciudades y la eliminará del array. Durante el juego
 * deberemos pasar por todas las ciudades en orden aleatorio, pero sin repetir ninguna de ellas.
 */
- (void)selectRandomCity;

/**
 * Muestra una ciudad en el mapaCiudad.
 * Llama a la función setRegion para centrar el mapa.
 * Si al ir a mostrar una nueva ciudad vemos que nuestro array ya no tiene más elementos, daremos
 * la opción de volver a empezar el juego.
 */
- (void)showCity;

/**
 * Centra un mapa en una región (MKCoordinateRegion) con centro y tamaño indicado por los parámetros.
 *
 * @param center Center point for the region.
 * @param distance Size.
 * @param map Map object.
 */
- (void)setRegion:(CLLocationCoordinate2D)center distance:(int)distance inMap:(MKMapView *)map;

#pragma mark - UIGestureRecognizer

/**
 * Recoge las coordenadas del punto donde ha pulsado el jugador.
 * Llama a la función para mostrar una anotación en ese punto.
 *
 * @param gestureRecognizer Long press gesture recognizer object.
 */
- (void)handleLongPressGesture:(UILongPressGestureRecognizer *)gestureRecognizer;

#pragma mark - IBActions

/**
 * Desactiva el longPress gesture.
 * Llama a la función que calcula la distancia entre el lugar donde el jugador ha puesto la anotación
 * y la ubicación de la ciudad.
 * Centra el mapaMundo en las coordenadas de la ciudad.
 * Llama a la función mostrarAnotacion para mostrar una anotación en las coordenadas de la ciudad,
 * con su nombre y distancia.
 * Llama a la función de dibujar línea.
 *
 * @param button Sender object.
 * @return Actions described above.
 */
- (IBAction)checkAnswer:(UIButton *)button;

/**
 * Llama a la función de borrarAnotaciones.
 * Llama a la función de mostrarCiudad.
 * Vuelve a agregar el longPress gesture recognizer al mapa.
 *
 * @param button Sender object.
 *
 * @return Next city.
 */
- (IBAction)nextCity:(UIButton *)button;

@end

