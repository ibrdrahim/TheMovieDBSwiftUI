//
//  ReviewCell.swift
//  TheMovieDB
//
//  Created by ibrahim on 25/07/20.
//  Copyright © 2020 ibrahim. All rights reserved.
//

import SwiftUI

struct ReviewCell: View {
    var review: Review
    var body: some View {
        HStack(spacing: 20) {
            VStack(alignment: .leading, spacing: 10) {
                Text("A review by \(review.author)")
                    .foregroundColor(.fontTheme)
                    .font(.caption)
                Text(review.content)
                    .font(.subheadline)
                    .foregroundColor(.fontTheme)
                    .multilineTextAlignment(.leading)
                    .lineLimit(5)
                HStack{
                    Spacer()
                    Button("read the rest.."){
                        UIApplication.shared.open(URL(string: self.review.url)!)
                    }.accentColor(.blue)
                }
            }
        }
        .padding(10)
        .background(Color.viewTheme)
        .cornerRadius(10)
        .shadow(radius: 10)
    }
}

struct ReviewCell_Previews: PreviewProvider {
    static var previews: some View {
        ReviewCell(review: Review(author: "SWITCH.", content: "I guess I can commend Warner Bros. for attempting to revitalise their Scooby-Doo brand and give parents something to show their kids while they've been stuck at home, but when there's a plethora of new and old (much, much better) kid's films, the best thing would be to Scooby-Dooby-do your kids a favour and skip this one.\r\n- Ashley Teresa\r\n\r\nRead Ashley's full article...\r\nhttps://www.maketheswitch.com.au/article/review-scoob-mystery-swapped-for-money-hungry-mayhem", id: "5ed47fd8528b2e00206f3274", url: "https://www.themoviedb.org/review/5ed47fd8528b2e00206f3274"))
    }
}
