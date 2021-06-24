//
//    Artist.swift
//  BykeaCaseStudy
//
//  Created by Hafiz Saad on 24/06/2021.
//
import Foundation

struct Artist : Codable {

	let artistId : Int?
	let artistName : String?
	let artistViewUrl : String?
	let artworkUrl100 : String?
	let artworkUrl30 : String?
	let artworkUrl60 : String?
	let collectionArtistId : Int?
	let collectionArtistName : String?
	let collectionCensoredName : String?
	let collectionExplicitness : String?
	let collectionId : Int?
	let collectionName : String?
	let collectionPrice : Float?
	let collectionViewUrl : String?
	let country : String?
	let currency : String?
	let discCount : Int?
	let discNumber : Int?
	let isStreamable : Bool?
	let kind : String?
	let previewUrl : String?
	let primaryGenreName : String?
	let releaseDate : String?
	let trackCensoredName : String?
	let trackCount : Int?
	let trackExplicitness : String?
	let trackId : Int?
	let trackName : String?
	let trackNumber : Int?
	let trackPrice : Float?
	let trackTimeMillis : Int?
	let trackViewUrl : String?
	let wrapperType : String?


	enum CodingKeys: String, CodingKey {
		case artistId = "artistId"
		case artistName = "artistName"
		case artistViewUrl = "artistViewUrl"
		case artworkUrl100 = "artworkUrl100"
		case artworkUrl30 = "artworkUrl30"
		case artworkUrl60 = "artworkUrl60"
		case collectionArtistId = "collectionArtistId"
		case collectionArtistName = "collectionArtistName"
		case collectionCensoredName = "collectionCensoredName"
		case collectionExplicitness = "collectionExplicitness"
		case collectionId = "collectionId"
		case collectionName = "collectionName"
		case collectionPrice = "collectionPrice"
		case collectionViewUrl = "collectionViewUrl"
		case country = "country"
		case currency = "currency"
		case discCount = "discCount"
		case discNumber = "discNumber"
		case isStreamable = "isStreamable"
		case kind = "kind"
		case previewUrl = "previewUrl"
		case primaryGenreName = "primaryGenreName"
		case releaseDate = "releaseDate"
		case trackCensoredName = "trackCensoredName"
		case trackCount = "trackCount"
		case trackExplicitness = "trackExplicitness"
		case trackId = "trackId"
		case trackName = "trackName"
		case trackNumber = "trackNumber"
		case trackPrice = "trackPrice"
		case trackTimeMillis = "trackTimeMillis"
		case trackViewUrl = "trackViewUrl"
		case wrapperType = "wrapperType"
	}
	init(from decoder: Decoder) throws {
		let values = try decoder.container(keyedBy: CodingKeys.self)
		artistId = try values.decodeIfPresent(Int.self, forKey: .artistId)
		artistName = try values.decodeIfPresent(String.self, forKey: .artistName)
		artistViewUrl = try values.decodeIfPresent(String.self, forKey: .artistViewUrl)
		artworkUrl100 = try values.decodeIfPresent(String.self, forKey: .artworkUrl100)
		artworkUrl30 = try values.decodeIfPresent(String.self, forKey: .artworkUrl30)
		artworkUrl60 = try values.decodeIfPresent(String.self, forKey: .artworkUrl60)
		collectionArtistId = try values.decodeIfPresent(Int.self, forKey: .collectionArtistId)
		collectionArtistName = try values.decodeIfPresent(String.self, forKey: .collectionArtistName)
		collectionCensoredName = try values.decodeIfPresent(String.self, forKey: .collectionCensoredName)
		collectionExplicitness = try values.decodeIfPresent(String.self, forKey: .collectionExplicitness)
		collectionId = try values.decodeIfPresent(Int.self, forKey: .collectionId)
		collectionName = try values.decodeIfPresent(String.self, forKey: .collectionName)
		collectionPrice = try values.decodeIfPresent(Float.self, forKey: .collectionPrice)
		collectionViewUrl = try values.decodeIfPresent(String.self, forKey: .collectionViewUrl)
		country = try values.decodeIfPresent(String.self, forKey: .country)
		currency = try values.decodeIfPresent(String.self, forKey: .currency)
		discCount = try values.decodeIfPresent(Int.self, forKey: .discCount)
		discNumber = try values.decodeIfPresent(Int.self, forKey: .discNumber)
		isStreamable = try values.decodeIfPresent(Bool.self, forKey: .isStreamable)
		kind = try values.decodeIfPresent(String.self, forKey: .kind)
		previewUrl = try values.decodeIfPresent(String.self, forKey: .previewUrl)
		primaryGenreName = try values.decodeIfPresent(String.self, forKey: .primaryGenreName)
		releaseDate = try values.decodeIfPresent(String.self, forKey: .releaseDate)
		trackCensoredName = try values.decodeIfPresent(String.self, forKey: .trackCensoredName)
		trackCount = try values.decodeIfPresent(Int.self, forKey: .trackCount)
		trackExplicitness = try values.decodeIfPresent(String.self, forKey: .trackExplicitness)
		trackId = try values.decodeIfPresent(Int.self, forKey: .trackId)
		trackName = try values.decodeIfPresent(String.self, forKey: .trackName)
		trackNumber = try values.decodeIfPresent(Int.self, forKey: .trackNumber)
		trackPrice = try values.decodeIfPresent(Float.self, forKey: .trackPrice)
		trackTimeMillis = try values.decodeIfPresent(Int.self, forKey: .trackTimeMillis)
		trackViewUrl = try values.decodeIfPresent(String.self, forKey: .trackViewUrl)
		wrapperType = try values.decodeIfPresent(String.self, forKey: .wrapperType)
	}


}
