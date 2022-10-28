package com.group7.artshare.controller

import com.group7.artshare.entity.*
import com.group7.artshare.repository.ArtItemInfoRepository
import org.springframework.beans.factory.annotation.Autowired
import org.springframework.web.bind.annotation.CrossOrigin
import org.springframework.web.bind.annotation.RequestMapping
import org.springframework.web.bind.annotation.RestController
import com.group7.artshare.repository.ArtItemRepository
import com.group7.artshare.repository.EventInfoRepository
import com.group7.artshare.repository.PhysicalExhibitionRepository
import org.springframework.web.bind.annotation.GetMapping
import java.util.Calendar


@RestController
@CrossOrigin(origins = ["*"], allowedHeaders = ["*"])
@RequestMapping("homepage")
class Homepage {

    @Autowired
    lateinit var artItemRepository: ArtItemRepository

    @Autowired
    lateinit var physicalExhibitionRepository: PhysicalExhibitionRepository

    @Autowired
    lateinit var eventInfoRepository: EventInfoRepository

    @Autowired
    lateinit var artItemInfoRepository: ArtItemInfoRepository

    @GetMapping("getGenericArtItems")
    fun getRecommendedArtItemsGeneric() : List<ArtItem> {

        //create hardcoded data below
        var artItemList = mutableListOf<ArtItem>()
        var artItem1 = ArtItem()
        var artItemInfo1 = ArtItemInfo()
        artItemInfo1.name = "Starry Night"
        artItemInfo1.labels = "{\"classical\", \"painting\"}"
        artItemInfo1.description = "A reflection of my soul from a fuzzy night."
        artItemInfo1.category = "Classical"
        artItemInfo1.imageUrl = "https://media.overstockart.com/optimized/cache/data/product_images/VG485-1000x1000.jpg"
        artItem1.artItemInfo = artItemInfoRepository.save(artItemInfo1)


        artItemList.add(artItem1)

        var artItem2 = ArtItem()
        var artItemInfo2 = ArtItemInfo()
        artItemInfo2.name = "Mediterranean Landscape"
        artItemInfo2.labels = "{\"classical\", \"painting\"}"
        artItemInfo2.description = "Emotional hurricane on a dull landscape, too dull for an artistic soul as mine."
        artItemInfo2.category = "Classical"
        artItemInfo2.imageUrl = "https://uploads4.wikiart.org/images/pablo-picasso/mediterranean-landscape-1952.jpg!Large.jpg"
        artItem2.artItemInfo = artItemInfoRepository.save(artItemInfo2)


        artItemList.add(artItem1)
        artItemList.add(artItem2)



        return artItemRepository.saveAll(artItemList)


        //return artItemRepository.findAll()
    }

    @GetMapping("getGenericEvents")
    fun getRecommendedEventsGeneric() : List<PhysicalExhibition> {

        //hardcoded data below
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
        eventList.add(event1)


        return physicalExhibitionRepository.saveAll(eventList)

        //return eventRepository.findAll();
    }

    @GetMapping("getEventsForUser")
    fun getRecommendedEventsForUser() : List<PhysicalExhibition> {
        //hardcoded data below
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
        eventList.add(event1)

        return physicalExhibitionRepository.saveAll(eventList)


        //return eventRepository.findAll();
    }

    @GetMapping("getArtItemsForUser")
    fun getRecommendedArtItemsForUser() : List<ArtItem> {
        //create hardcoded data below
        var artItemList = mutableListOf<ArtItem>()
        var artItem1 = ArtItem()
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

        artItemList.add(artItem2)

        return artItemRepository.saveAll(artItemList)

    }

}