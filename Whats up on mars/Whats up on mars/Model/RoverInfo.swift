//
//  RoverInfo.swift
//  Whats up on mars
//
//  Created by Jan Gilles on 06.06.20.
//  Copyright © 2020 Jan Gilles. All rights reserved.
//

import Foundation


class RoverInfo {
    
    private static let fhaz = Camera(name: "FHAZ", fullName: "Front Hazard Avoidance Camera")
    private static let rhaz = Camera(name: "RHAZ", fullName: "Rear Hazard Avoidance Camera")
    private static let mast = Camera(name: "MAST", fullName: "Mast Camera")
    private static let chemcam = Camera(name: "CHEMCAM", fullName: "Chemistry and Camera Complex")
    private static let mahli = Camera(name: "MAHLI", fullName: "Mars Hand Lens Imager")
    private static let mardi = Camera(name: "MARDI", fullName: "Mars Descent Imager")
    private static let navcam = Camera(name: "NAVCAM", fullName: "Navigation Camera")
    private static let pancam = Camera(name: "PANCAM", fullName: "Panoramic Camera")
    private static let minites = Camera(name: "MINITES", fullName: "Miniature Thermal Emission Spectrometer")
    
    static let rovers: [String : Rover] = [
        "Curiosity" : Rover(id: 5, name: "Curiosity", landingDate: "2012-08-06", launchDate: "2011-11-26", status: "active", maxSol: -1, maxDate: "", totalImages: -1, cameras: [fhaz, rhaz, mast, chemcam, mahli, mardi, navcam]),
        
        "Opportunity" : Rover(id: 6, name: "Opportunity", landingDate: "2004-01-25", launchDate: "2003-07-07", status: "active", maxSol: -1, maxDate: "", totalImages: -1, cameras: [fhaz, rhaz, navcam, pancam, minites]),
        
        "Spirit" : Rover(id: 7, name: "Spirit", landingDate: "2004-01-04", launchDate: "2003-06-10", status: "active", maxSol: -1, maxDate: "", totalImages: -1, cameras: [fhaz, rhaz, navcam, pancam, minites])
    ]
}
