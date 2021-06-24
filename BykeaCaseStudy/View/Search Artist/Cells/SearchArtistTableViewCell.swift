//
//  SearchArtistTableViewCell.swift
//  BykeaCaseStudy
//
//  Created by Hafiz Saad on 24/06/2021.
//

import UIKit
import Kingfisher

class SearchArtistTableViewCell: UITableViewCell {

    @IBOutlet weak var albumArtImage : UIImageView!

    @IBOutlet weak var songNameLabel : UILabel!
    @IBOutlet weak var artistLabel : UILabel!
    @IBOutlet weak var albumLabel : UILabel!

    @IBOutlet weak var playingIndicatorImage : UIImageView!

    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

    class func cellForTableView(tableView: UITableView, atIndexPath indexPath: IndexPath) -> SearchArtistTableViewCell {
        let kSearchArtistTableViewCellIdentifier = "kSearchArtistTableViewCellIdentifier"

        let cell = tableView.dequeueReusableCell(withIdentifier: kSearchArtistTableViewCellIdentifier, for: indexPath) as! SearchArtistTableViewCell
        return cell
    }
    
    func configureCell(artist: Artist)
    {
        songNameLabel.text = artist.trackName
        artistLabel.text = artist.artistName
        albumLabel.text = artist.collectionName
        albumArtImage.kf.indicatorType = .activity

        if let iconURL = artist.artworkUrl100
        {
            if iconURL != ""
            {
                KF.url((URL(string: iconURL.addingPercentEncoding(withAllowedCharacters: CharacterSet.urlQueryAllowed) ?? "")!),cacheKey: "\(iconURL)")
                    .onSuccess(
                    { (imageResult) in
                        
                    })
                    .set(to: albumArtImage)
            }
            else
            {
                print("empty")
            }
        }
        
    }
    
}
