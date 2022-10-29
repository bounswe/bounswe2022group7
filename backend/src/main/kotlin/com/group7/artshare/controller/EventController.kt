package com.group7.artshare.controller

import com.group7.artshare.entity.*
import com.group7.artshare.repository.*
import org.springframework.beans.factory.annotation.Autowired
import org.springframework.data.repository.findByIdOrNull
import org.springframework.web.bind.annotation.CrossOrigin
import org.springframework.web.bind.annotation.GetMapping
import org.springframework.web.bind.annotation.PathVariable
import org.springframework.web.bind.annotation.RequestMapping
import org.springframework.web.bind.annotation.RestController
import java.util.*


@RestController
@CrossOrigin(origins = ["*"], allowedHeaders = ["*"])
@RequestMapping("event")
class EventController {

    @Autowired
    lateinit var physicalExhibitionRepository: PhysicalExhibitionRepository

    @Autowired
    lateinit var onlineGalleryRepository: OnlineGalleryRepository

    @Autowired
    lateinit var eventInfoRepository: EventInfoRepository

    @Autowired
    lateinit var registeredUserRepository: RegisteredUserRepository

    @Autowired
    lateinit var artItemRepository : ArtItemRepository

    @GetMapping("{id}")
    fun getRecommendedEventsGeneric(@PathVariable("id") id: Long) : Event? {
        var physicalExhibition : PhysicalExhibition? =  physicalExhibitionRepository.findByIdOrNull(id)
        var onlineGallery : OnlineGallery? = onlineGalleryRepository.findByIdOrNull(id)
        if (Objects.isNull(physicalExhibition)) {
            return onlineGallery
        }
        return physicalExhibition
    }

    //TODO:  below endpoints are for checking manytomany relation annotations. Will be removed after validation
    @GetMapping("a")
    fun a() : PhysicalExhibition? {
        var eventList = mutableListOf<PhysicalExhibition>()

        var event1 = PhysicalExhibition()
        var eventInfo1 = EventInfo()
        eventInfo1.posterUrl = "https://i.pinimg.com/originals/c7/9a/b6/c79ab6b3943e4e75fa0742a8ce9a76e6.jpg"
        eventInfo1.category = "{\"kubism\", \"oil painting\", \"wooden sculpture\"}"
        eventInfo1.endingDate = Calendar.getInstance().time
        eventInfo1.title = "Venice the Mourning City"
        eventInfo1.description = "Stories of seperations, tears of loves"
        eventInfo1.labels = "{\"romantic\", \"engraving\", \"carving\""
        eventInfo1.startingDate = Calendar.getInstance().time
        eventInfo1 = eventInfoRepository.save(eventInfo1)
        event1.eventInfo = eventInfo1
        var location = Location()
        location.address = "Turkey"
        event1.location = location
        return physicalExhibitionRepository.save(event1)
    }

    @GetMapping("b")
    fun b() : RegisteredUser?{
        var user = RegisteredUser()
        var lisOfFollowing = mutableSetOf(RegisteredUser(), RegisteredUser())
        user.following = lisOfFollowing
        user.bookmarkedPhysicalExhibitions = mutableSetOf(PhysicalExhibition(), PhysicalExhibition())
        return registeredUserRepository.save(user)

    }

    @GetMapping("c/{id}")
    fun c(@PathVariable id : Long) : RegisteredUser? {
        var user = registeredUserRepository.findByIdOrNull(id)
        if (user != null) {
            user.isVerified = true
            return registeredUserRepository.save(user)
        }
        return null
    }

    @GetMapping("d/{id}")
    fun d(@PathVariable id : Long) : RegisteredUser? {
        var user = registeredUserRepository.findByIdOrNull(id)
        if (user != null) {
            user.bookmarkedPhysicalExhibitions.add(PhysicalExhibition())
            //var t = user.bookmarkedPhysicalExhibitions.find { physicalExhibition -> physicalExhibition.id.equals(4) }
            //if(t != null){
            //    t.eventInfo = EventInfo()
            //}
            return registeredUserRepository.save(user)
        }
        return null
    }
}