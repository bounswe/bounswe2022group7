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
import java.util.*

import io.swagger.v3.oas.annotations.security.SecurityRequirement;
import io.swagger.v3.oas.annotations.tags.Tag;


@RestController
@CrossOrigin(origins = ["*"], allowedHeaders = ["*"])
@RequestMapping("data")
@Tag(name = "Mock Data", description = "Created Mock data")
@SecurityRequirement(name = "bearerAuth")
class DataProp {

    @Autowired
    lateinit var artItemInfoRepository: ArtItemInfoRepository

    @Autowired
    lateinit var artItemRepository: ArtItemRepository

    @Autowired
    lateinit var eventInfoRepository : EventInfoRepository

    @Autowired
    lateinit var physicalExhibitionRepository: PhysicalExhibitionRepository

    @Autowired
    lateinit var registeredUserRepository: RegisteredUserRepository

    @PostMapping("createArtItem")
    fun a() : Boolean {
        var accountInfo1 = AccountInfo("email@email.com", "janedoe", "31415926")
        accountInfo1.country = "England"
        accountInfo1.profilePictureUrl = "https://images.pexels.com/photos/733872/pexels-photo-733872.jpeg?auto=compress&cs=tinysrgb&dpr=1&w=500"
        accountInfo1.surname = "Doe"
        accountInfo1.name = "Jane"
        var owner1 = RegisteredUser(accountInfo1, setOf())
        owner1.level = 3
        owner1 = registeredUserRepository.save(owner1)


        var accountInfo2 = AccountInfo("email2@email.com", "joedoe", "31415936")
        accountInfo2.country = "Sydney"
        accountInfo2.profilePictureUrl = "https://images.pexels.com/photos/733872/pexels-photo-733872.jpeg?auto=compress&cs=tinysrgb&dpr=1&w=500"
        accountInfo2.surname = "Doe"
        accountInfo2.name = "Joe"
        var owner2 = RegisteredUser(accountInfo2, setOf())
        owner2.level = 4
        owner2 = registeredUserRepository.save(owner2)

        var accountInfo3 = AccountInfo("email3@email.com", "janettdoe", "31415976")
        accountInfo3.country = "Katalan"
        accountInfo3.profilePictureUrl = "https://images.pexels.com/photos/733872/pexels-photo-733872.jpeg?auto=compress&cs=tinysrgb&dpr=1&w=500"
        accountInfo3.surname = "Doe"
        accountInfo3.name = "Janett"
        var owner3 = RegisteredUser(accountInfo3, setOf())
        owner3.level = 3
        owner3 = registeredUserRepository.save(owner3)



        //create hardcoded data below
        var artItemList = mutableListOf<ArtItem>()

        var artItem1 = ArtItem()
        var artItemInfo1 = ArtItemInfo()
        artItem1.auction =null
        var artist1 = Artist(accountInfo1,setOf())

        artItem1.creator = artist1
        var comment1 = Comment()
        comment1.author = owner2
        comment1.text = "Amazing!"
        comment1.creationDate = Calendar.getInstance().time

        var comment2 = Comment()
        comment2.author = owner3
        comment2.text = "Wonderful! I feel goosebumps!"
        comment2.creationDate = Calendar.getInstance().time

        var comment3 = Comment()
        comment3.author = owner1
        comment3.text = "Shclecht!"
        comment3.creationDate = Calendar.getInstance().time


        artItem1.commentList = mutableListOf(comment2, comment1)
        artItem1.lastPrice = 0.0
        artItem1.onAuction = false
        artItemInfo1.name = "Starry Night"
        artItemInfo1.labels = "[\"classical\", \"painting\"]"
        artItemInfo1.description = "A reflection of my soul from a fuzzy night."
        artItemInfo1.category = "Classical"
        artItemInfo1.imageUrl = "https://media.overstockart.com/optimized/cache/data/product_images/VG485-1000x1000.jpg"
        artItem1.artItemInfo = artItemInfo1
        artItem1.owner = owner1

        artItemList.add(artItem1)

        var artItem2 = ArtItem()
        var artItemInfo2 = ArtItemInfo()
        artItemInfo2.name = "Mediterranean Landscape"
        artItemInfo2.labels = "[\"classical\", \"painting\"]"
        artItemInfo2.description = "Emotional hurricane on a dull landscape, too dull for an artistic soul as mine."
        artItemInfo2.category = "Classical"
        artItemInfo2.imageUrl = "https://uploads4.wikiart.org/images/pablo-picasso/mediterranean-landscape-1952.jpg!Large.jpg"
        artItem2.artItemInfo = artItemInfo2
        artItem2.auction = Auction()
        var artist2 = Artist(accountInfo2,setOf())
        artItem2.creator = artist2
        artItem2.commentList = mutableListOf(comment3)
        artItem2.lastPrice = 0.0
        artItem2.onAuction = false
        artItem2.owner = owner3
        owner1.bookmarkedArtItems.add(artItem2)
        owner1.following.add(owner2)

        artItemList.add(artItem2)

        artItemRepository.saveAll(artItemList)
        return true

    }


    @PostMapping("createEvents")
    fun b() : Boolean {
        var eventList = mutableListOf<PhysicalExhibition>()

        var event1 = PhysicalExhibition()
        var eventInfo1 = EventInfo()
        eventInfo1.posterUrl = "https://i.pinimg.com/originals/c7/9a/b6/c79ab6b3943e4e75fa0742a8ce9a76e6.jpg"
        eventInfo1.category = "[\"kubism\", \"oil painting\", \"wooden sculpture\"]"
        eventInfo1.endingDate = Calendar.getInstance().time
        eventInfo1.title = "Venice the Mourning City"
        eventInfo1.description = "Stories of seperations, tears of loves"
        eventInfo1.labels = "[\"romantic\", \"engraving\", \"carving\"]"
        eventInfo1.startingDate = Calendar.getInstance().time
        eventInfo1 = eventInfoRepository.save(eventInfo1)
        event1.eventInfo = eventInfo1
        var location = Location()
        location.address = "Venice"
        event1.location = location
        eventList.add(event1)

        var event2 = PhysicalExhibition()
        var eventInfo2 = EventInfo()
        eventInfo2.posterUrl = "https://www.kadindanalhaberi.com/images/haberler/2020/08/sanatsal_mozaik_sergisi_kahramanmaras_kalede_aciliyor_h7195_9e45b.jpg"
        eventInfo2.category = "[\"mosaic\", \"seramic\"]"
        eventInfo2.endingDate = Calendar.getInstance().time
        eventInfo2.title = "Footsteps of the Ancients"
        eventInfo2.description = "A breeze whining from old times telling secret stories."
        eventInfo2.labels = "[\"mystery\", \"ceramic\", \"wood\"]"
        eventInfo2.startingDate = Calendar.getInstance().time
        eventInfo2 = eventInfoRepository.save(eventInfo1)
        event2.eventInfo = eventInfo2
        var location2 = Location()
        location2.address = "England"
        event2.location = location2
        eventList.add(physicalExhibitionRepository.save(event1))
        eventList.add(physicalExhibitionRepository.save(event2))

        return true
    }

}