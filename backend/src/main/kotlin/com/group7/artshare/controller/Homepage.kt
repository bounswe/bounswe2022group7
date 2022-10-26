package com.group7.artshare.controller

import com.group7.artshare.entity.*
import org.springframework.beans.factory.annotation.Autowired
import org.springframework.web.bind.annotation.CrossOrigin
import org.springframework.web.bind.annotation.RequestMapping
import org.springframework.web.bind.annotation.RestController
import com.group7.artshare.repository.ArtItemRepository
import com.group7.artshare.repository.EventRepository
import org.springframework.web.bind.annotation.GetMapping
import java.util.Calendar


@RestController
@CrossOrigin(origins = ["*"], allowedHeaders = ["*"])
@RequestMapping("homepage")
class Homepage {

    @Autowired
    lateinit var artItemRepository: ArtItemRepository

    @Autowired
    lateinit var eventRepository: EventRepository

    @GetMapping("getGenericArtItems")
    fun getRecommendedArtItemsGeneric() : List<ArtItem> {

        //create hardcoded data below
        var artItemList = mutableListOf<ArtItem>()
        var artItem1 = ArtItem()
        var artItemInfo = ArtItemInfo()
        artItem1.artItemInfo = artItemInfo
        artItem1.auction = Auction()
        var artist1 = Artist()
        artItem1.creator = artist1
        artItem1.commentList = mutableListOf(Comment(), Comment(), Comment())
        artItem1.creationDate = Calendar.getInstance().time
        artItem1.lastPrice = 0.0
        artItem1.onAuction = false
        artItem1.owner = RegisteredUser()

        artItemList.add(artItem1)


        var artItem2 = ArtItem()
        var artItemInfo2 = ArtItemInfo()
        artItem2.artItemInfo = artItemInfo2
        artItem2.auction = Auction()
        var artist2 = Artist()
        artItem2.creator = artist2
        artItem2.commentList = mutableListOf(Comment(), Comment(), Comment())
        artItem2.creationDate = Calendar.getInstance().time
        artItem2.lastPrice = 0.0
        artItem2.onAuction = false
        artItem2.owner = RegisteredUser()

        artItemList.add(artItem2)


        return artItemList


        //return artItemRepository.findAll()
    }

    @GetMapping("getGenericEvents")
    fun getRecommendedEventsGeneric() : List<Event> {

        //hardcoded data below
        var eventList = mutableListOf<Event>()

        var event1 = Event()
        var artist1 = Artist()
        event1.creator = artist1
        var eventInfo1 = EventInfo()
        event1.eventInfo = eventInfo1
        event1.collaborators = mutableListOf(Artist(), Artist())
        event1.commentList = mutableListOf(Comment(), Comment(), Comment())
        event1.lastEdited = Calendar.getInstance().time
        event1.participants = mutableListOf(RegisteredUser(), RegisteredUser())
        eventList.add(event1)

        var event2 = Event()
        var artist2 = Artist()
        event1.creator = artist2
        var eventInfo2 = EventInfo()
        event2.eventInfo = eventInfo2
        event2.collaborators = mutableListOf(Artist(), Artist())
        event2.commentList = mutableListOf(Comment(), Comment(), Comment())
        event2.lastEdited = Calendar.getInstance().time
        event2.participants = mutableListOf(RegisteredUser(), RegisteredUser())
        eventList.add(event2)

        return eventList

        //return eventRepository.findAll();
    }

    @GetMapping("getEventsForUser")
    fun getRecommendedEventsForUser() : List<Event> {
        //hardcoded data below
        var eventList = mutableListOf<Event>()

        var event1 = Event()
        var artist1 = Artist()
        event1.creator = artist1
        var eventInfo1 = EventInfo()
        event1.eventInfo = eventInfo1
        event1.collaborators = mutableListOf(Artist(), Artist())
        event1.commentList = mutableListOf(Comment(), Comment(), Comment())
        event1.lastEdited = Calendar.getInstance().time
        event1.participants = mutableListOf(RegisteredUser(), RegisteredUser())
        eventList.add(event1)

        var event2 = Event()
        var artist2 = Artist()
        event1.creator = artist2
        var eventInfo2 = EventInfo()
        event2.eventInfo = eventInfo2
        event2.collaborators = mutableListOf(Artist(), Artist())
        event2.commentList = mutableListOf(Comment(), Comment(), Comment())
        event2.lastEdited = Calendar.getInstance().time
        event2.participants = mutableListOf(RegisteredUser(), RegisteredUser())
        eventList.add(event2)

        return eventList

        //return eventRepository.findAll();
    }

    @GetMapping("getArtItemsForUser")
    fun getRecommendedArtItemsForUser() : List<ArtItem> {
        var artItemList = mutableListOf<ArtItem>()
        var artItem1 = ArtItem()
        var artItemInfo = ArtItemInfo()
        artItem1.artItemInfo = artItemInfo
        artItem1.auction = Auction()
        var artist1 = Artist()
        artItem1.creator = artist1
        artItem1.commentList = mutableListOf(Comment(), Comment(), Comment())
        artItem1.creationDate = Calendar.getInstance().time
        artItem1.lastPrice = 0.0
        artItem1.onAuction = false
        artItem1.owner = RegisteredUser()


        var artItem2 = ArtItem()
        var artItemInfo2 = ArtItemInfo()
        artItem2.artItemInfo = artItemInfo2
        artItem2.auction = Auction()
        var artist2 = Artist()
        artItem2.creator = artist2
        artItem2.commentList = mutableListOf(Comment(), Comment(), Comment())
        artItem2.creationDate = Calendar.getInstance().time
        artItem2.lastPrice = 0.0
        artItem2.onAuction = false
        artItem2.owner = RegisteredUser()

        return artItemList

        //return artItemRepository.findAll();
    }

}