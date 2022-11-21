package com.group7.artshare.service

import com.group7.artshare.entity.*
import com.group7.artshare.repository.ArtItemRepository
import com.group7.artshare.repository.ImageRepository
import com.group7.artshare.repository.OnlineGalleryRepository
import com.group7.artshare.repository.PhysicalExhibitionRepository
import com.group7.artshare.request.OnlineGalleryRequest
import com.group7.artshare.request.PhysicalExhibitionRequest
import org.springframework.data.repository.findByIdOrNull
import org.springframework.http.HttpStatus
import org.springframework.stereotype.Service
import org.springframework.web.server.ResponseStatusException

@Service
class EventService(
    private val physicalExhibitionRepository: PhysicalExhibitionRepository,
    private val onlineGalleryRepository: OnlineGalleryRepository,
    private val artItemRepository: ArtItemRepository,
    private val imageRepository: ImageRepository
) {
    fun createPhysicalExhibition(
        physicalExhibitionRequest: PhysicalExhibitionRequest, user: RegisteredUser
    ): PhysicalExhibition {
        val newPhysicalExhibition = PhysicalExhibition()
        if (user is Artist) {
            newPhysicalExhibition.creator = user
            user.hostedEvents.add(newPhysicalExhibition)
        } else throw ResponseStatusException(
            HttpStatus.BAD_REQUEST,
            "Registered users cannot create physical exhibitions"
        )
        newPhysicalExhibition.location = physicalExhibitionRequest.location
        newPhysicalExhibition.rules = physicalExhibitionRequest.rules
        if (physicalExhibitionRequest.eventInfo?.posterId?.let { imageRepository.existsById(it) } == false) throw ResponseStatusException(
            HttpStatus.BAD_REQUEST,
            "There is no image in the database with this id"
        )
        newPhysicalExhibition.eventInfo = physicalExhibitionRequest.eventInfo
        physicalExhibitionRepository.save(newPhysicalExhibition)
        return newPhysicalExhibition
    }

    fun createOnlineGallery(onlineGalleryRequest: OnlineGalleryRequest, user: RegisteredUser): OnlineGallery {
        val newOnlineGallery = OnlineGallery()
        if (onlineGalleryRequest.eventInfo?.posterId?.let { imageRepository.existsById(it) } == false) throw ResponseStatusException(
            HttpStatus.BAD_REQUEST,
            "There is no image in the database with this id"
        )
        newOnlineGallery.eventInfo = onlineGalleryRequest.eventInfo
        onlineGalleryRequest.artItemIds?.forEach {
            val artItem = artItemRepository.findByIdOrNull(it) ?: throw ResponseStatusException(
                HttpStatus.BAD_REQUEST, "Art item list includes an id with no corresponding art item"
            )
            newOnlineGallery.artItems.add(artItem)
        }
        if (user is Artist) {
            newOnlineGallery.creator = user
            user.hostedEvents.add(newOnlineGallery)
        } else throw ResponseStatusException(HttpStatus.BAD_REQUEST, "Regular users cannot create online galleries")
        onlineGalleryRepository.save(newOnlineGallery)
        return newOnlineGallery
    }

    fun deleteEvent(
        id: Long, user: RegisteredUser
    ) {
        if (!((physicalExhibitionRepository.existsById(id)) || onlineGalleryRepository.existsById(id))) throw ResponseStatusException(
            HttpStatus.BAD_REQUEST, "There is no event in the database with corresponding id"
        )
        if (user is Artist) {
            var event: Event = user.hostedEvents.firstOrNull { it.id == id } ?: throw ResponseStatusException(
                HttpStatus.UNAUTHORIZED,
                "Event does not belong to this user"
            )
            user.hostedEvents.remove(event)
            if (event is PhysicalExhibition) physicalExhibitionRepository.delete(event)
            if (event is OnlineGallery) onlineGalleryRepository.delete(event)
        } else {
            throw ResponseStatusException(HttpStatus.UNAUTHORIZED, "Regular Users cannot delete events")
        }
    }
}