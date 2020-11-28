//
//  SearchMovieCell.swift
//  FSMovie
//
//  Created by Игорь Попов on 27.11.2020.
//  Copyright © 2020 AirIgor. All rights reserved.
//

import UIKit


class SearchMovieCell: UITableViewCell {
    
    static let reuseId = "SearchCell"
    
    @IBOutlet weak var releaseDate: UILabel!
    @IBOutlet weak var posterImg: UIImageView!
    @IBOutlet weak var voteRank: UILabel!
    @IBOutlet weak var nameMovie: UILabel!
    @IBOutlet weak var voteView: UIView!
    @IBOutlet weak var viewCell: UIView!
    @IBOutlet weak var shadowCell: UIView!
    @IBOutlet weak var movieInfo: UILabel!
    
    override func awakeFromNib() {
        super .awakeFromNib()
        imageBounds()
        configViewCell()
        configVoteView()
    }
    
    private func imageBounds() {
        posterImg.clipsToBounds = true
        posterImg.layer.cornerRadius = posterImg.frame.height / 2
        posterImg.contentMode = .scaleAspectFill
        posterImg.layer.cornerRadius = 8
    }
    
    private func configVoteView() {
        voteView.layer.cornerRadius = 8
        voteRank.textColor = .white
        voteRank.textAlignment = .center
    }
    
    private func configViewCell() {
        viewCell.backgroundColor = .white
        viewCell.layer.cornerRadius = 8
        self.selectionStyle = .none
        viewCell.clipsToBounds = true
        shadowCell.backgroundColor = .clear
        shadowCell.addShadow()
    }
    
}
