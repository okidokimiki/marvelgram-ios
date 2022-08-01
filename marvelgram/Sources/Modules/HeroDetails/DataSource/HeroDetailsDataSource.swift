final class HeroDetailsDataSource {
    var selectedHeroCellModel: HeroCellModel?
    var otherHeroCellModels: [HeroCellModel]?
    
    init(selectedHeroCellModel: HeroCellModel?, otherHeroCellModels: [HeroCellModel]?) {
        self.selectedHeroCellModel = selectedHeroCellModel
        self.otherHeroCellModels = otherHeroCellModels
    }
}
