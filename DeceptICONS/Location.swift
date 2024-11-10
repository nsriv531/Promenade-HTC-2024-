//
//  Location.swift
//  DeceptICONS
//
//  Created by Kai Azim on 2024-11-09.
//

import SwiftUI

struct Location: Identifiable, Hashable, Codable {
    var id: String { name }
    let name: String

    static var all: [Location] {
        stations + parksDowntown + parksNW + parksNE + parksSW + parksSE
    }

    // Stations
    static let stations = [
        Location(name: "Tuscany Station"),
        Location(name: "Crowfoot Station"),
        Location(name: "Dalhousie Station"),
        Location(name: "Brentwood Station"),
        Location(name: "University Station"),
        Location(name: "Banff Trail Station"),
        Location(name: "Lions Park Station"),
        Location(name: "SAIT/AUArts/Jubilee Station"),
        Location(name: "Sunnyside Station"),
        Location(name: "8 Street SW Station"),
        Location(name: "7 Street SW Station"),
        Location(name: "6 Street SW Station"),
        Location(name: "4 Street SW Station"),
        Location(name: "3 Street SW Station"),
        Location(name: "1 Street SW Station"),
        Location(name: "Centre St Station"),
        Location(name: "City Hall/Bow Valley College Station"),
        Location(name: "Victoria Park/Stampede Station"),
        Location(name: "Erlton/Stampede Station"),
        Location(name: "39 Avenue Station"),
        Location(name: "Chinook Station"),
        Location(name: "Heritage Station"),
        Location(name: "Southland Station"),
        Location(name: "Anderson Station"),
        Location(name: "Canyon Meadows Station"),
        Location(name: "Fish Creek-Lacombe Station"),
        Location(name: "Shawnessy Station"),
        Location(name: "Somerset-Bridlewood Station"),
        Location(name: "69 Street Station"),
        Location(name: "Sirocco Station"),
        Location(name: "45 Street Station"),
        Location(name: "Westbrook Station"),
        Location(name: "Shaganappi Point Station"),
        Location(name: "Sunalta Station"),
        Location(name: "Downtown West-Kerby Station"),
        Location(name: "Bridgeland-Memorial Station"),
        Location(name: "Zoo Station"),
        Location(name: "Barlow/Max Bell Station"),
        Location(name: "Franklin Station"),
        Location(name: "Marlborough Station"),
        Location(name: "Rundle Station"),
        Location(name: "Whitehorn Station"),
        Location(name: "McKnight-Westwinds Station"),
        Location(name: "Martindale Station"),
        Location(name: "Saddletowne Station")
    ]

    // Downtown Parks
    static let parksDowntown = [
        Location(name: "Barb Scott Park"),
        Location(name: "Beaulieu Gardens"),
        Location(name: "Bow to Bluff"),
        Location(name: "Central Memorial Park"),
        Location(name: "Century Gardens"),
        Location(name: "Connaught Park"),
        Location(name: "Devonian Gardens"),
        Location(name: "Eau Claire Plaza"),
        Location(name: "Haultain Park"),
        Location(name: "Humpy Hollow"),
        Location(name: "和園 Harmony Park"),
        Location(name: "Lois Szabo Commons"),
        Location(name: "Nat Christie Park"),
        Location(name: "Olympic Plaza"),
        Location(name: "Peace Park"),
        Location(name: "Poetic Park"),
        Location(name: "Prince's Island Park"),
        Location(name: "Rouleauville Square"),
        Location(name: "Cowboys Park"),
        Location(name: "Sien Lok Park"),
        Location(name: "St. Patrick's Island Park"),
        Location(name: "Thomson Family Park"),
        Location(name: "Tomkins Park")
    ]
    
    // NW Parks
    static let parksNW = [
        Location(name: "12 Mile Coulee"),
        Location(name: "Baker Park"),
        Location(name: "Bowmont Park"),
        Location(name: "Bowness Park"),
        Location(name: "West Confederation Park"),
        Location(name: "Confederation Park"),
        Location(name: "Crescent Park"),
        Location(name: "Dale Hodges Park"),
        Location(name: "Edgemont Ravine"),
        Location(name: "Haskayne Legacy Park"),
        Location(name: "McHugh Bluff"),
        Location(name: "Nose Hill Park"),
        Location(name: "Poppy Plaza"),
        Location(name: "Ranchlands Park"),
        Location(name: "Riley Park"),
        Location(name: "Shouldice Park")
    ]
    
    // NE Parks
    static let parksNE = [
        Location(name: "Big Marlborough Park"),
        Location(name: "Bottomlands Park"),
        Location(name: "Laycock Park"),
        Location(name: "Munro Park"),
        Location(name: "Prairie Winds Park"),
        Location(name: "Rotary Park"),
        Location(name: "Tom Campbell's Hill"),
        Location(name: "West Nose Creek")
    ]
    
    // SW Parks
    static let parksSW = [
        Location(name: "Battalion Park"),
        Location(name: "Bridlewood Wetlands"),
        Location(name: "Clearwater Park"),
        Location(name: "Douglas Fir Trail"),
        Location(name: "Edworthy Park"),
        Location(name: "Griffith Woods"),
        Location(name: "J.H. Woods Park"),
        Location(name: "Kingsland Summer Park"),
        Location(name: "Lawrey Gardens"),
        Location(name: "North Glenmore Park"),
        Location(name: "River Park"),
        Location(name: "Sandy Beach"),
        Location(name: "South Glenmore Park"),
        Location(name: "Stanley Park"),
        Location(name: "Strathcona Ravines"),
        Location(name: "Weaselhead Flats")
    ]
    
    // SE Parks
    static let parksSE = [
        Location(name: "Beaverdam Flats"),
        Location(name: "Carburn Park"),
        Location(name: "Elliston Park"),
        Location(name: "Inglewood Bird Sanctuary"),
        Location(name: "Jack Long Park"),
        Location(name: "Lindsay Park"),
        Location(name: "Mills Park"),
        Location(name: "Old Refinery Park"),
        Location(name: "Pearce Estate Park"),
        Location(name: "Ralph Klein Park"),
        Location(name: "Reader Rock Garden"),
        Location(name: "Sue Higgins Park"),
        Location(name: "Valleyview Park")
    ]
}
