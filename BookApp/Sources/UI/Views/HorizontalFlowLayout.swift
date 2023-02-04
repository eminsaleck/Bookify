//
//  File.swift
//  
//
//  Created by LEMIN DAHOVICH on 04.02.2023.
//
import UIKit

public final class HorizontalFlowLayout: UICollectionViewFlowLayout {

    private var preferredWidth: CGFloat
    private var preferredHeight: CGFloat
    private let margin: CGFloat
    private let minRows: Int

    public init(preferredWidth: CGFloat,
         preferredHeight: CGFloat,
         margin: CGFloat = 16.0,
         minRows: Int = .zero) {
        self.preferredWidth = preferredWidth
        self.preferredHeight = preferredHeight
        self.margin = margin
        self.minRows = minRows
        super.init()

        sectionInsetReference = .fromSafeArea
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError()
    }

    public override func prepare() {
        super.prepare()
        var finalWidth = preferredHeight
        var finalHeight = preferredWidth
        if minRows != .zero, let collectionView = collectionView {
            let totalHorizontalSafeAreaInset = collectionView.safeAreaInsets.left + collectionView.safeAreaInsets.right

            let horizontalSpacePerItem = margin * 2 + totalHorizontalSafeAreaInset + minimumInteritemSpacing
            let totalHorizontalSpace = horizontalSpacePerItem * CGFloat(minRows - 1)
            let maximumItemWidth = ((collectionView.bounds.size.width - totalHorizontalSpace) / CGFloat(minRows)).rounded(.down)

            if maximumItemWidth < preferredWidth {
                finalWidth = maximumItemWidth
                finalHeight = finalWidth * (preferredHeight / preferredWidth)
            }
        }
        

        itemSize = CGSize(width: finalWidth, height: finalHeight)
        sectionInset = UIEdgeInsets(top: margin, left: margin,
                                    bottom: margin, right: margin)
    }

    func updatePreferredWidth(_ width: CGFloat) {
        self.preferredWidth = width
    }

    func updatePreferredHeight(_ height: CGFloat) {
        self.preferredHeight = height
    }

}
