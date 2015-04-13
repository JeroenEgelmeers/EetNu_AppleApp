//
//  DetailViewController.swift
//  eindOpdrachtMBD2_hmwegelm
//
//  Created by User on 13/04/15.
//  Copyright (c) 2015 hmwegelm2060058. All rights reserved.
//

import UIKit
import MapKit

class DetailViewController: UIViewController {

    var detailInfo:Restaurant!
    @IBOutlet weak var restaurantName: UILabel!
    @IBOutlet weak var restaurantStreet: UILabel!
    @IBOutlet weak var restaurantZipcode: UILabel!
    @IBOutlet weak var restaurantCity: UILabel!
    @IBOutlet weak var restaurantMap: MKMapView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // SHOULD IMPLEMENT detailinfo["name"] to the restaurantName.
        restaurantName.text     = detailInfo.rName
        restaurantStreet.text   = "Straat: \(detailInfo.rStreet)"
        restaurantZipcode.text  = "Postcode: \(detailInfo.rPostcode)"
        restaurantCity.text     = "Plaats: \(detailInfo.rPlace)"
        // Do any additional setup after loading the view.
        
        // set initial location in Honolulu
        var setLat = detailInfo.rLocLat as? Double
        var setLong = detailInfo.rLocLong as? Double
        if (setLat != nil && setLong != nil) {
            let initialLocation = CLLocation(latitude: setLat!, longitude: setLong!)
            centerMapOnLocation(initialLocation)
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    let regionRadius: CLLocationDistance = 10000
    func centerMapOnLocation(location: CLLocation) {
        let coordinateRegion = MKCoordinateRegionMakeWithDistance(location.coordinate,
            regionRadius * 2.0, regionRadius * 2.0)
        restaurantMap.setRegion(coordinateRegion, animated: true)
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}