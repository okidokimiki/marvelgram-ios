protocol HeroDetailsViewInput: AnyObject {
    func updateUI(with model: HeroCellModel?)
    func finishLayoutSubviews()
}
