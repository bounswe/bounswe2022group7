package com.group7.artshare.controller

import com.group7.artshare.entity.*
import com.group7.artshare.repository.*
import org.springframework.beans.factory.annotation.Autowired
import org.springframework.data.repository.findByIdOrNull
import org.springframework.web.bind.annotation.CrossOrigin
import org.springframework.web.bind.annotation.GetMapping
import org.springframework.web.bind.annotation.PathVariable
import org.springframework.web.bind.annotation.PostMapping
import org.springframework.web.bind.annotation.RequestMapping
import org.springframework.web.bind.annotation.RestController


@RestController
@CrossOrigin(origins = ["*"], allowedHeaders = ["*"])
@RequestMapping("data")
class DataProp {

    @Autowired
    lateinit var artItemInfoRepository: ArtItemInfoRepository

    @Autowired
    lateinit var artItemRepository: ArtItemRepository

    @PostMapping("createArtItem")
    fun a() : Boolean {
        //create hardcoded data below
        var artItemList = mutableListOf<ArtItem>()
        var artItem1 = ArtItem()
        var artItemInfo = ArtItemInfo()
        artItem1.artItemInfo = artItemInfo
        artItem1.auction = Auction()
        var artist1 = Artist()
        artItem1.creator = artist1
        artItem1.commentList = mutableListOf(Comment(), Comment(), Comment())
        artItem1.lastPrice = 0.0
        artItem1.onAuction = false
        var artItemInfo1 = ArtItemInfo()
        artItemInfo1.name = "Starry Night"
        artItemInfo1.labels = "{\"classical\", \"painting\"}"
        artItemInfo1.description = "A reflection of my soul from a fuzzy night."
        artItemInfo1.category = "Classical"
        artItemInfo1.imageUrl = "https://media.overstockart.com/optimized/cache/data/product_images/VG485-1000x1000.jpg"
        artItem1.artItemInfo = artItemInfoRepository.save(artItemInfo1)
        artItem1.artItemInfo = artItemInfo1

        artItemList.add(artItem1)

        var artItem2 = ArtItem()
        var artItemInfo2 = ArtItemInfo()
        artItemInfo2.name = "Mediterranean Landscape"
        artItemInfo2.labels = "{\"classical\", \"painting\"}"
        artItemInfo2.description = "Emotional hurricane on a dull landscape, too dull for an artistic soul as mine."
        artItemInfo2.category = "Classical"
        artItemInfo2.imageUrl = "https://uploads4.wikiart.org/images/pablo-picasso/mediterranean-landscape-1952.jpg!Large.jpg"
        artItem2.artItemInfo = artItemInfoRepository.save(artItemInfo2)
        artItem2.artItemInfo = artItemInfo2
        artItem2.auction = Auction()
        var artist2 = Artist()
        artItem2.creator = artist2
        artItem2.commentList = mutableListOf(Comment(), Comment(), Comment())
        artItem2.lastPrice = 0.0
        artItem2.onAuction = false
        artItemList.add(artItem2)

        artItemRepository.saveAll(artItemList)
        return true

    }

}
