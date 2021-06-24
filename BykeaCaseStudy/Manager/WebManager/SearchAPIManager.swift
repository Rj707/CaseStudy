//
//    SearchAPIManager.swift
//  BykeaCaseStudy
//
//  Created by Hafiz Saad on 24/06/2021.
//

import Foundation
import Alamofire

final class SearchAPIManager
{
    // Can't init is singleton
    private init() { }
    
    // MARK: Shared Instance
    
    static let shared = SearchAPIManager()
    
    // Passenger Profile API
    
    func getArtistResponse(term:String, completion : @escaping (_ isSuccessful: Bool, _ errorMessage : String?, _ resultedJSON : ArtistResponse?) -> Void)
    {
        APIManagerBase().stopAllrequests()
        let params  = ["term":term, "entity":"song", "attribute":"artistTerm"]
        let url = APIManagerBase().getUrl(forRoute:  Route.SearchArtist.rawValue, params: params)
        APIManagerBase().getRequestWith(route: url!.absoluteString, parameters: [:], success:
        { (jsonResponse, data) in
            
            do
            {
                let json = try JSONSerialization.jsonObject(with: data as! Data, options: []) as? [String: Any]
                let responsePassengerProfile = try JSONDecoder().decode(ArtistResponse.self, from: data as! Data)
                
                completion(true, nil, responsePassengerProfile)
            }
            catch
            {
                completion(false,error.localizedDescription, nil)
            }
            
        }, failure:
        { (error) in
            
            completion(false, error.localizedDescription, nil)
            
        }, errorPopup: false)
    }
   
}
