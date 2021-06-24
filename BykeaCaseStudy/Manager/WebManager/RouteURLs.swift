//
//    Route.swift
//  BykeaCaseStudy
//
//  Created by Hafiz Saad on 24/06/2021.
//
enum Route: String
{
    
    case SearchArtist = "/search"
//    case SearchArtist = "/search?term=abc&entity=song&attribute=artistTerm"

    func url() -> String
    {
        return Constants.BaseURL + self.rawValue
    }
}
