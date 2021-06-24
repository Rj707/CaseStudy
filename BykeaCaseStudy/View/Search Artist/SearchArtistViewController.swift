//
//  SearchArtistViewController.swift
//  BykeaCaseStudy
//
//  Created by Hafiz Saad on 24/06/2021.
//

import UIKit

class SearchArtistViewController: BaseViewController
{
    
    // MARK: - Variables & Outlets
    
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var artistSearchBar: UISearchBar!
    
    @IBOutlet weak var musicControl: UIView!
    @IBOutlet weak var musicControlBottomConstraint: NSLayoutConstraint!
    
    @IBOutlet weak var playPauseToggleButton: UIButton!

    var timer: Timer?
    
    var sections = [String]()
    
    var viewModel = SearchArtistViewModel()
    
    var playingSongIndex = IndexPath.init(row: -1, section: 0)
    
    // MARK: - UIViewController Methods
    
    override func viewDidLoad()
    {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
        
        viewModel.delegate = self
        setupUI()
        
    }
    
    func setupUI()
    {
        tableView.tableFooterView = UIView()
        tableView.contentInset.bottom = 0
    }
    
    // MARK: - IBAction

    @IBAction func playPauseMusicButtonTouched(_ sender : UIButton)
    {
        sender.isSelected = !sender.isSelected
        if sender.isSelected
        {
            print(sender.isSelected)
            sender.setImage(UIImage.init(named: "play_song"), for: .normal)
            viewModel.pausePreview()
        }
        else
        {
            print(sender.isSelected)
            sender.setImage(UIImage.init(named: "pause_song"), for: .normal)
            viewModel.player?.play()
        }
    }
    
    func handleMusicControl(shouldShow : Bool? = true)
    {
        if shouldShow!
        {
            playPauseToggleButton.setImage(UIImage.init(named: "pause_song"), for: .normal)
            playPauseToggleButton.isSelected = !playPauseToggleButton.isSelected

            tableView.contentInset.bottom = 128

            self.musicControlBottomConstraint.constant = 0

            UIView.animate(withDuration: 0.5)
            {
                self.view.layoutIfNeeded()
                
                self.musicControl.alpha = 1
            }
        }
        else
        {
            if viewModel.player?.timeControlStatus == .playing
            {
                viewModel.player?.pause()
            }
            playPauseToggleButton.setImage(UIImage.init(named: "play_song"), for: .normal)
            playPauseToggleButton.isSelected = !playPauseToggleButton.isSelected

            tableView.contentInset.bottom = 0

            self.musicControlBottomConstraint.constant = -128

            UIView.animate(withDuration: 0.5)
            {
                self.view.layoutIfNeeded()
                
                self.musicControl.alpha = 0
            }
        }
    }
    
}

// MARK: - UITableViewDataSource, UITableViewDelegate
extension SearchArtistViewController: UITableViewDelegate, UITableViewDataSource
{
    
    func numberOfSections(in tableView: UITableView) -> Int
    {
        if viewModel.isLoading
        {
            return 0
        }
        
        if viewModel.filteredDataSource.count == 0
        {
            self.showEmptyTableViewMessage()
            return 0
        }
        
        self.hideEmptyTableViewMessage(tableView: tableView)
//        self.tableView.backgroundView = UIView()
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int
    {
        return viewModel.filteredDataSource.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell
    {
        let cell = SearchArtistTableViewCell.cellForTableView(tableView: tableView, atIndexPath: indexPath)
        cell.configureCell(artist: viewModel.filteredDataSource[indexPath.row])
        cell.playingIndicatorImage.isHidden = true
        if playingSongIndex == indexPath
        {
            cell.playingIndicatorImage.isHidden = false

        }
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath)
    {
        artistSearchBar.resignFirstResponder()
        var arrayOfIndexPaths = [indexPath]
        if playingSongIndex.row != -1
        {
            arrayOfIndexPaths.append(playingSongIndex)
            playingSongIndex = indexPath
            tableView.reloadRows(at: arrayOfIndexPaths, with: .none)
        }
        else
        {
            playingSongIndex = indexPath
            tableView.reloadRows(at: arrayOfIndexPaths, with: .none)
        }
        
        handleMusicControl(shouldShow: true)
        let previewUrl = viewModel.filteredDataSource[indexPath.row].previewUrl
        viewModel.playPreview(url: previewUrl!)
    }
}

// MARk: - HomeViewModelDelegate
extension SearchArtistViewController: SearchArtistViewModelDelegate
{
    func didSearchArtists()
    {
        self.tableView.reloadData()
    }
}

// MARK: - UISearchBarDelegate
extension SearchArtistViewController: UISearchBarDelegate
{
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String)
    {
        timer?.invalidate()  // Cancel any previous timer
        
        timer = Timer.scheduledTimer(timeInterval: 0.5, target: self, selector: #selector(performSearchWithDelay), userInfo: nil, repeats: false)
    }
    
    func searchBarDidBeginEditing(_ searchBar: UISearchBar) -> Bool
    {
        self.hideEmptyTableViewMessage(tableView: tableView)
        return true
    }
    
    func searchBarTextDidEndEditing(_ searchBar: UISearchBar)
    {
        
    }
    
    @objc func performSearchWithDelay()
    {
        handleMusicControl(shouldShow: false)

        viewModel.searchArtistWith(name: artistSearchBar.text!)
    }
}

extension SearchArtistViewController
{
    func showEmptyTableViewMessage()
    {
        playingSongIndex = IndexPath.init(row: -1, section: 0)

        let noResultView = EmptyTableViewBackgroundView.instanceFromNib()
        
        var emptyTableText = "No artist to show, please tap the button below to start searching artists"
        noResultView.noResultButton.isHidden = false

        if artistSearchBar.text!.count > 0
        {
            emptyTableText = "Oops! \n\nNo artist to show for current search"
            noResultView.noResultButton.isHidden = true
        }
        
        noResultView.titleLabel.text = emptyTableText
        noResultView.titleLabel.numberOfLines = 0
        
        noResultView.noResultButton.setTitle("Search Artist", for: .normal)
        
        noResultView.imageView.image = UIImage.init(named: "artist")
        
        tableView.backgroundColor = .clear
        tableView.backgroundView = noResultView
        tableView.separatorStyle = .none
        
        noResultView.layoutIfNeeded()
        
        noResultView.noResultButtonAction =
        {
            self.artistSearchBar.becomeFirstResponder()
            self.hideEmptyTableViewMessage(tableView: self.tableView)
        }
    }
    
    func hideEmptyTableViewMessage(tableView:UITableView)
    {
        tableView.backgroundView = nil
    }
}
