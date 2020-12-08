//
//  PersonMoviesCell.swift
//  FSMovie
//
//  Created by Игорь Попов on 08.12.2020.
//  Copyright © 2020 AirIgor. All rights reserved.
//

import UIKit

class PersonMoviesCell: UITableViewCell {
    
    static let reuseId = "PersonMoviesCell"

    @IBOutlet weak var movieRealeseDate: UILabel!
    @IBOutlet weak var movieName: UILabel!
    @IBOutlet weak var movieImage: UIImageView!
    @IBOutlet weak var shadowView: UIView!
    @IBOutlet weak var voteLbl: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        setupShadowView()
    }
    
    
    private func setupShadowView() {
        shadowView.clipsToBounds = true
        shadowView.layer.cornerRadius = 5
        shadowView.addShadowPerson()
        movieImage.contentMode = .scaleAspectFill
        movieImage.layer.cornerRadius = 5
    }
}
