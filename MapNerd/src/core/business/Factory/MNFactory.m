//
//  MNFactory.m
//  MapNerd
//
//  Created by Jose Manuel Ramírez Martínez on 06/12/15.
//  Copyright © 2015 Jose Manuel Ramírez Martínez. All rights reserved.
//

#import "MNFactory.h"

@implementation MNFactory

- (NSMutableArray *)cities
{
    MNCity *city0 = [[MNCity alloc] init];
    city0.name = @"BARCELONA";
    city0.latitude = 41.385064;
    city0.longitude = 2.173403;
    
    MNCity *city1 = [[MNCity alloc] init];
    city1.name = @"MADRID";
    city1.latitude = 40.416775;
    city1.longitude = -3.703790;
    
    MNCity *city2 = [[MNCity alloc] init];
    city2.name = @"NEW YORK";
    city2.latitude = 40.714353;
    city2.longitude = -74.005973;
    
    MNCity *city3 = [[MNCity alloc] init];
    city3.name = @"PARÍS";
    city3.latitude = 48.856614;
    city3.longitude = 2.352222;
    
    MNCity *city4 = [[MNCity alloc] init];
    city4.name = @"ROMA";
    city4.latitude = 41.892916;
    city4.longitude = 12.482520;
    
    MNCity *city5 = [[MNCity alloc] init];
    city5.name = @"SAN FRANCISCO";
    city5.latitude = 37.774929;
    city5.longitude = -122.419416;
    
    MNCity *city6 = [[MNCity alloc] init];
    city6.name = @"LONDRES";
    city6.latitude = 51.511214;
    city6.longitude = -0.119824;
    
    MNCity *city7 = [[MNCity alloc] init];
    city7.name = @"MOSCÚ";
    city7.latitude = 55.751242;
    city7.longitude = 37.618422;
    
    MNCity *city8 = [[MNCity alloc] init];
    city8.name = @"TOKYO";
    city8.latitude = 35.689487;
    city8.longitude = 139.691706;
    
    MNCity *city9 = [[MNCity alloc] init];
    city9.name = @"SIDNEY";
    city9.latitude = -33.867487;
    city9.longitude = 151.206990;
    
    MNCity *city10 = [[MNCity alloc] init];
    city10.name = @"ATENES";
    city10.latitude = 37.983716;
    city10.longitude = 23.729310;
    
    MNCity *city11 = [[MNCity alloc] init];
    city11.name = @"MEXICO DF";
    city11.latitude = 19.432608;
    city11.longitude = -99.133208;
    
    MNCity *city12 = [[MNCity alloc] init];
    city12.name = @"SHANGHAI";
    city12.latitude = 31.230393;
    city12.longitude = 121.473704;
    
    MNCity *city13 = [[MNCity alloc] init];
    city13.name = @"MIAMI";
    city13.latitude = 25.788969;
    city13.longitude = -80.226439;
    
    MNCity *city14 = [[MNCity alloc] init];
    city14.name = @"ISTANBUL";
    city14.latitude = 41.005270;
    city14.longitude = 28.976960;
    
    MNCity *city15 = [[MNCity alloc] init];
    city15.name = @"BERLÍN";
    city15.latitude = 52.519171;
    city15.longitude = 13.406091;
    
    MNCity *city16 = [[MNCity alloc] init];
    city16.name = @"BUENOS AIRES";
    city16.latitude = -34.603723;
    city16.longitude = -58.381593;
    
    MNCity *city17 = [[MNCity alloc] init];
    city17.name = @"LA HABANA";
    city17.latitude = 23.116800;
    city17.longitude = -82.388557;
    
    MNCity *city18 = [[MNCity alloc] init];
    city18.name = @"CIUDAD DEL CABO";
    city18.latitude = -33.924869;
    city18.longitude = 18.424055;
    
    MNCity *city19 = [[MNCity alloc] init];
    city19.name = @"TIMBUCTÚ";
    city19.latitude = 16.775320;
    city19.longitude = -3.008265;
    
    NSArray *cities = @[city0, city1, city2, city3, city4, city5, city6, city7, city8, city9, city10, city11, city12, city13, city14, city15, city16, city17, city18, city19];
    NSMutableArray *array = [[NSMutableArray alloc] initWithArray:cities];
    
    return array;
}

@end
