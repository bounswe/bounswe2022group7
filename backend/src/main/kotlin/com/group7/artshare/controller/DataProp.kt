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


@RestController
@CrossOrigin(origins = ["*"], allowedHeaders = ["*"])
@RequestMapping("data")
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

    @Autowired
    lateinit var imageRepository: ImageRepository

    @PostMapping("createArtItem")
    fun a() : Boolean {
        var accountInfo1 = AccountInfo("email@email.com", "janedoe", "31415926")
        accountInfo1.country = "England"
        accountInfo1.surname = "Doe"
        accountInfo1.name = "Jane"
        var owner1 = RegisteredUser(accountInfo1, setOf())
        owner1.level = 3
        owner1 = registeredUserRepository.save(owner1)


        var accountInfo2 = AccountInfo("email2@email.com", "joedoe", "31415936")
        accountInfo2.country = "Sydney"
        accountInfo2.surname = "Doe"
        accountInfo2.name = "Joe"
        var owner2 = RegisteredUser(accountInfo2, setOf())
        owner2.level = 4
        owner2 = registeredUserRepository.save(owner2)

        var accountInfo3 = AccountInfo("email3@email.com", "janettdoe", "31415976")
        accountInfo3.country = "Katalan"
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
        var image1 = Image()
        image1.base64String = "data:image/jpeg;base64,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"
        imageRepository.save(image1)
        artItemInfo1.imageId = image1.id
        artItem1.artItemInfo = artItemInfo1
        artItem1.owner = owner1

        artItemList.add(artItem1)

        var artItem2 = ArtItem()
        var artItemInfo2 = ArtItemInfo()
        artItemInfo2.name = "Mediterranean Landscape"
        artItemInfo2.labels = "[\"classical\", \"painting\"]"
        artItemInfo2.description = "Emotional hurricane on a dull landscape, too dull for an artistic soul as mine."
        artItemInfo2.category = "Classical"
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