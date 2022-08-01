struct HeroCellModel: Equatable {
    let name: String
    let description: String
    let url: String
    
    init(hero: Hero) {
        self.name = hero.name
        self.description = hero.description
        self.url = hero.thumbnail.url
    }
}
