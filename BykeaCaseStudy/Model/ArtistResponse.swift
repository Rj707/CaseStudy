//
//	ArtistResponse.swift
//  BykeaCaseStudy
//
//  Created by Hafiz Saad on 24/06/2021.
//
import Foundation

struct ArtistResponse : Codable {

	let resultCount : Int?
	let results : [Artist]?


	enum CodingKeys: String, CodingKey {
		case resultCount = "resultCount"
		case results = "results"
	}
	init(from decoder: Decoder) throws {
		let values = try decoder.container(keyedBy: CodingKeys.self)
		resultCount = try values.decodeIfPresent(Int.self, forKey: .resultCount)
		results = try values.decodeIfPresent([Artist].self, forKey: .results)
	}


}
