//
//  TrashMap.swift
//  TrashTalk
//
//  Created by Nathan Macfarlane on 1/18/19.
//  Copyright © 2019 Nathan Macfarlane. All rights reserved.
//

import Foundation
import MapKit

class TrashMap: MKMapView {
    override init(frame: CGRect) {
        super.init(frame: frame)
    }

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
}
