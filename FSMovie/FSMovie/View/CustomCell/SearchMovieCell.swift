//
//  SearchMovieCell.swift
//  FSMovie
//
//  Created by Игорь Попов on 27.11.2020.
//  Copyright © 2020 AirIgor. All rights reserved.
//

import UIKit


class SearchMovieCell: UITableViewCell {
    
    
    @IBOutlet weak private var releaseDate: UILabel!
    @IBOutlet weak private var posterImg: UIImageView!
    @IBOutlet weak private var voteRank: UILabel!
    @IBOutlet weak private var nameMovie: UILabel!
    @IBOutlet weak private var voteView: UIView!
    @IBOutlet weak private var viewCell: UIView!
    @IBOutlet weak private var shadowCell: UIView!
    @IBOutlet weak private var movieInfo: UILabel!
    
    override func awakeFromNib() {
        super .awakeFromNib()
        imageBounds()
        configView()
        configVoteView()
    }
    
    func configCellInformation(movie: Result) {
        movieInfo.text = movie.overview
        let imgUrl = ApiKeys.startImgUrl + "\(movie.posterPath ?? "")"
        posterImg.downloaded(from: imgUrl)
        voteRank.text = "\(movie.voteAverage)"
        nameMovie.text = movie.title
        releaseDate.setCorrectlyDate(movie)
        voteView.backgroundColor = colorForVote().calculaeteColorVote(movie.voteAverage)
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
    
    private func configView() {
        viewCell.backgroundColor = .white
        viewCell.layer.cornerRadius = 8
        self.selectionStyle = .none
        viewCell.clipsToBounds = true
        shadowCell.backgroundColor = .clear
        shadowCell.addShadow()
    }
    
}
