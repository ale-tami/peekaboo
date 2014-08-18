//
//  PBMapViewController.m
//  Peek-a-Boo
//
//  Created by Alejandro Tami on 18/08/14.
//  Copyright (c) 2014 Alejandro Tami. All rights reserved.
//

#import "PBMapViewController.h"
#import <MapKit/MapKit.h>

@interface PBMapViewController () <MKMapViewDelegate>

@property (weak, nonatomic) IBOutlet MKMapView *mapView;

@end

@implementation PBMapViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.address = @"Pje Levellier 400-498, Santiago del Estero, Argentina";
    
    CLGeocoder *geocoder = [[CLGeocoder alloc]init];
    [geocoder geocodeAddressString:self.address completionHandler:^(NSArray *placemarks, NSError *error) {
    
        for (CLPlacemark * place in placemarks) {
            MKPointAnnotation *annotation = [[MKPointAnnotation alloc]init];
            annotation.coordinate = place.location.coordinate;
            annotation.title = place.subLocality;
            [self.mapView addAnnotation:annotation];

        }
    
    }];

}


- (IBAction)onClose:(UIButton *)sender
{
    [UIView transitionFromView:self.view
                        toView:[self presentingViewController].view
                      duration:0.5
                       options:UIViewAnimationOptionTransitionCurlDown
                    completion:^(BOOL finished) {
                        
                        
                    }];

}

-(MKAnnotationView *)mapView:(MKMapView *)mapView viewForAnnotation:(id<MKAnnotation>)annotation
{
        
        
    if (annotation != self.mapView.userLocation){
        
        MKPinAnnotationView *pin = [[MKPinAnnotationView alloc]initWithAnnotation:annotation reuseIdentifier:nil];
        pin.canShowCallout = YES;
        pin.rightCalloutAccessoryView = [UIButton buttonWithType:UIButtonTypeDetailDisclosure];

        
        return pin;
    }
    else {
        return  nil;
    }
}
 
 -(void)mapView:(MKMapView *)mapView annotationView:(MKAnnotationView *)view calloutAccessoryControlTapped:(UIControl *)control{
     
     CLLocationCoordinate2D centerCoordinate = view.annotation.coordinate;
     MKCoordinateSpan coordinateSpan;
     coordinateSpan.latitudeDelta = 0.01;
     coordinateSpan.longitudeDelta = 0.01;
     MKCoordinateRegion region;
     region.center = centerCoordinate;
     region.span = coordinateSpan;
     
     [self.mapView setRegion:region animated:YES];
     
     
 }


@end
