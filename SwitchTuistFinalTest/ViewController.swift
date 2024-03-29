//
//  ViewController.swift
//  SwitchTuistFinalTest
//
//  Created by Muzlive_Player on 2023/08/09.
//

import UIKit
import SnapKit

import RxSwift
import RxCocoa

import AssetsPickerViewController
import Photos

import DateToolsSwift

class ViewController: UIViewController {
    private let logoImageView = UIImageView()
    private let assetsViewControllerButton = UIButton()
    private let dateLabel = UILabel()
    private let ealierResultLabel = UILabel()
    
    private let presentingObjcVCButton = UIButton()
    
    lazy var disposeBag = DisposeBag()

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .purple
        setupView()
        setupLayout()
        setupAttribute()
        setupBinding()
    }
}

extension ViewController {
    private func setupView(){
        [
            logoImageView,
            assetsViewControllerButton,
            dateLabel, ealierResultLabel,
            presentingObjcVCButton
        ].forEach {
            view.addSubview($0)
        }
    }
    
    private func setupLayout() {
        assetsViewControllerButton.snp.makeConstraints {
            $0.height.width.equalTo(150)
            $0.centerX.centerY.equalToSuperview()
        }
        
        logoImageView.snp.makeConstraints {
            $0.bottom.equalTo(assetsViewControllerButton.snp.top)
                .offset(-24)
            $0.width.height.equalTo(120)
            $0.centerX.equalToSuperview()
        }
        
        dateLabel.snp.makeConstraints {
            $0.top.equalTo(assetsViewControllerButton.snp.bottom)
                .offset(16)
            $0.centerX.equalToSuperview()
        }
        
        ealierResultLabel.snp.makeConstraints {
            $0.top.equalTo(dateLabel.snp.bottom)
                .offset(16)
            $0.centerX.equalToSuperview()
        }
        
        presentingObjcVCButton.snp.makeConstraints {
            $0.top.equalTo(ealierResultLabel.snp.bottom)
                .offset(16)
            $0.width.equalTo(150)
            $0.height.equalTo(52)
            $0.centerX.equalToSuperview()
        }
    }
    
    private func setupAttribute(){
        assetsViewControllerButton.backgroundColor = .red
        assetsViewControllerButton.setTitle("assetsVCButton", for: .normal)
        
        logoImageView.image = UIImage(named: "logo")
        
        let now = Date()
        dateLabel.text = "\(now)"
        ealierResultLabel.text = "\(now.isEarlier(than: now))"
        
        presentingObjcVCButton.setTitle("move To objcVC", for: .normal)
        presentingObjcVCButton.backgroundColor = .blue
    }
    
    private func setupBinding(){
        assetsViewControllerButton.rx.tap
            .asDriver()
            .drive(onNext: { [weak self] _ in
                guard let self = self else { return }
                let nextVC = self.setupAssetsPickerView()
                nextVC.modalPresentationStyle = .overFullScreen
                self.present(nextVC, animated: false)
            })
            .disposed(by: disposeBag)
        
        presentingObjcVCButton.rx.tap
            .asDriver()
            .drive(onNext: { [weak self] _ in
                guard let self = self else { return }
                let nextVC = ObjcTestViewController()
//                nextVC.modalPresentationStyle = .overFullScreen
                self.present(nextVC, animated: false)
            })
            .disposed(by: disposeBag)
    }
}

extension ViewController {
    private func setupAssestConfig() -> AssetsPickerConfig {
        let predicate = NSPredicate(format: "mediaType = %d", PHAssetMediaType.image.rawValue)
        
        let options = PHFetchOptions()
        options.predicate = predicate
        
        let config = AssetsPickerConfig()
        config.albumIsShowEmptyAlbum = false
        config.assetFetchOptions = [.smartAlbum: options]
        config.assetsMaximumSelectionCount = 1
        return config
    }
    
    private func setupAssetsPickerView() -> AssetsPickerViewController {
        let picker = AssetsPickerViewController()
        picker.pickerConfig = setupAssestConfig()
        return picker
    }
}

