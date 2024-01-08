

import UIKit
import MapKit
import CoreLocation

class MapViewController: UIViewController, MKMapViewDelegate {
    
    var mapView: MKMapView!
    
    @objc func mapTypeChanged(_ segControl: UISegmentedControl) {
        switch segControl.selectedSegmentIndex {
        case 0:
            mapView.mapType = .standard
        case 1:
            mapView.mapType = .hybrid
        case 2:
            mapView.mapType = .satellite
        default:
            break
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        mapView = MKMapView()
        mapView.delegate = self
        view = mapView
        
        let standardString = NSLocalizedString("Standard", comment: "Standard map view")
        let hybridString = NSLocalizedString("Hybrid", comment: "Hybrid map view")
        let satelliteString = NSLocalizedString("Satellite", comment: "Satellite map view")
        let segmentedControl = UISegmentedControl(items: [standardString, hybridString, satelliteString])

        segmentedControl.backgroundColor = UIColor.systemBackground
        segmentedControl.selectedSegmentIndex = 0
        segmentedControl.addTarget(self, action: #selector(mapTypeChanged(_:)),
                                   for: .valueChanged)
        segmentedControl.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(segmentedControl)
        
        let topConstraint =
            segmentedControl.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor,
                                                  constant: 8)
        let margins = view.layoutMarginsGuide
        let leadingConstraint =
            segmentedControl.leadingAnchor.constraint(equalTo: margins.leadingAnchor)
        let trailingConstraint =
            segmentedControl.trailingAnchor.constraint(equalTo: margins.trailingAnchor)

        
        topConstraint.isActive = true
        leadingConstraint.isActive = true
        trailingConstraint.isActive = true
        
        let csufLocation = CLLocationCoordinate2D(latitude: 33.8824, 
                                                  longitude: -117.8854)
        let region = MKCoordinateRegion(center: csufLocation,
                                        latitudinalMeters: 5000,
                                        longitudinalMeters: 5000)
        mapView.setRegion(region, animated: true)
        let csufAnnotation = MKPointAnnotation()
        csufAnnotation.coordinate = csufLocation
        csufAnnotation.title = "California State University, Fullerton"
        mapView.addAnnotation(csufAnnotation)
        
        let hosp1Location = CLLocationCoordinate2D(latitude: 33.8943, 
                                                   longitude: -117.9274)
        let hosp1Annotation = MKPointAnnotation()
        hosp1Annotation.coordinate = hosp1Location
        hosp1Annotation.title = "Providence St. Jude Medical Center"
        mapView.addAnnotation(hosp1Annotation)
        
        let hosp2Location = CLLocationCoordinate2D(latitude: 33.88666, 
                                                   longitude: -117.84311)
        let hosp2Annotation = MKPointAnnotation()
        hosp2Annotation.coordinate = hosp2Location
        hosp2Annotation.title = "Placentia-Linda Hospital"
        mapView.addAnnotation(hosp2Annotation)
        
        let coordinates = [csufLocation, hosp1Location, hosp2Location]
        let polyline = MKPolyline(coordinates: coordinates, count: coordinates.count)
        mapView.addOverlay(polyline)
    }
    
    func mapView(_ mapView: MKMapView, viewFor annotation: MKAnnotation) -> MKAnnotationView? {
        if annotation is MKUserLocation {
            return nil
        }
        
        let annotationView = MKMarkerAnnotationView(annotation: annotation, 
                                                    reuseIdentifier: "pin")
        annotationView.canShowCallout = true
        return annotationView
    }
    
    func mapView(_ mapView: MKMapView, rendererFor overlay: MKOverlay) -> MKOverlayRenderer {
        if let polyline = overlay as? MKPolyline {
            let renderer = MKPolylineRenderer(overlay: polyline)
            renderer.strokeColor = UIColor.red
            renderer.lineWidth = 3
            return renderer
        }
        return MKOverlayRenderer()
    }
}
