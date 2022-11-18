package com.group7.artshare.service

import com.group7.artshare.entity.*
import com.group7.artshare.repository.*
import com.group7.artshare.request.*
import org.springframework.data.repository.findByIdOrNull
import org.springframework.http.HttpStatus
import org.springframework.security.crypto.password.PasswordEncoder
import org.springframework.stereotype.Service
import org.springframework.web.server.ResponseStatusException

@Service
class EventService(
    private val physicalExhibitionRepository: PhysicalExhibitionRepository,
    private val onlineGalleryRepository: OnlineGalleryRepository,
    private val artItemRepository: ArtItemRepository
) {
    fun createPhysicalExhibition(
        physicalExhibitionRequest: PhysicalExhibitionRequest,
        user: RegisteredUser
    ): PhysicalExhibition {
        val newPhysicalExhibition = PhysicalExhibition()
        if (user is Artist)
            newPhysicalExhibition.creator = user
        else
            throw ResponseStatusException(HttpStatus.BAD_REQUEST, "Registered users cannot create physical exhibitions")
        newPhysicalExhibition.location = physicalExhibitionRequest.location
        newPhysicalExhibition.rules = physicalExhibitionRequest.rules
        newPhysicalExhibition.eventInfo = physicalExhibitionRequest.eventInfo
        physicalExhibitionRepository.save(newPhysicalExhibition)
        return newPhysicalExhibition
    }

    fun createOnlineGallery(onlineGalleryRequest: OnlineGalleryRequest, user: RegisteredUser): OnlineGallery {
        val newOnlineGallery = OnlineGallery()
        if (user is Artist)
            newOnlineGallery.creator = user
        else
            throw ResponseStatusException(HttpStatus.BAD_REQUEST, "Registered users cannot create online galleries")
        newOnlineGallery.eventInfo = onlineGalleryRequest.eventInfo
        onlineGalleryRequest.artItemIds?.forEach {
            val artItem = artItemRepository.findByIdOrNull(it)
                ?: throw ResponseStatusException(
                    HttpStatus.BAD_REQUEST,
                    "Art item list includes an id with no corresponding art item"
                )
            newOnlineGallery.artItems.add(artItem)
        }
        onlineGalleryRepository.save(newOnlineGallery)
        return newOnlineGallery
    }


}