//
//  SearchArtistViewModel.swift
//  BykeaCaseStudy
//
//  Created by Hafiz Saad on 24/06/2021.
//

import Foundation
import AVFoundation


protocol SearchArtistViewModelDelegate: BaseViewModelDelegate
{
    func didSearchArtists()
}

class SearchArtistViewModel: BaseViewModel
{
    
    var dataSource = [Artist]()
    var filteredDataSource = [Artist]()
    var isLoading = false
    
    var player : AVPlayer?
    
    var delegate: SearchArtistViewModelDelegate?
    
    func searchArtistWith(name:String)
    {
        self.delegate?.showPorgress()
        isLoading = true
        
        SearchAPIManager.shared.getArtistResponse(term: name)
        { [weak self] (success, errorMessage, response) in
            
            guard let self = self else { return }
            self.delegate?.hideProgress()
            self.isLoading = false
            
            if success
            {
                
            }
            
            DispatchQueue.main.async
            {
                if success
                {
                    self.dataSource = (response?.results)!
                    self.filteredDataSource = self.dataSource
                    self.delegate?.didSearchArtists()
                }
                else
                {
                    self.delegate?.showErrorAlert(message: errorMessage!)
                }
            }
            
        }
    }
    
    func playPreview(url:String)
    {
        guard  let url = URL(string: url) else { return }
        player = AVPlayer(url: url as URL)
        guard let player = player  else { return }
        do
        {
            try AVAudioSession.sharedInstance().setCategory(.playback, mode: .default, options: [.mixWithOthers, .allowAirPlay])
           
            try AVAudioSession.sharedInstance().setActive(true)
            
            
        }
        catch
        {
            print(error)
        }
        
        player.play()

    }
    
    func pausePreview()
    {
        guard let player = player
        else
        {
            return
        }
        
        player.pause()
    }
    
}
