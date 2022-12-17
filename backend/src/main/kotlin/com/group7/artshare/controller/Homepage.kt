package com.group7.artshare.controller

import com.group7.artshare.DTO.ArtItemDTO
import com.group7.artshare.DTO.EventDTO
import com.group7.artshare.entity.*
import com.group7.artshare.repository.ArtItemRepository
import com.group7.artshare.repository.OnlineGalleryRepository
import com.group7.artshare.repository.PhysicalExhibitionRepository
import com.group7.artshare.service.JwtService
import org.springframework.beans.factory.annotation.Autowired
import org.springframework.http.HttpStatus
import org.springframework.web.bind.annotation.*
import org.springframework.web.server.ResponseStatusException
import java.util.*
import java.util.stream.Collectors


@RestController
@CrossOrigin(origins = ["*"], allowedHeaders = ["*"])
@RequestMapping("homepage")
class Homepage(private val jwtService: JwtService) {

    @Autowired
    lateinit var artItemRepository: ArtItemRepository

    @Autowired
    lateinit var physicalExhibitionRepository: PhysicalExhibitionRepository

    @Autowired
    lateinit var onlineGalleryRepository: OnlineGalleryRepository

    @GetMapping("event")
    fun getRecommendedEvents(
        @RequestHeader(
            value = "Authorization",
            required = false
        ) authorizationHeader: String?
    ): List<EventDTO> {
        try {
            authorizationHeader?.let {
                val user =
                    jwtService.getUserFromAuthorizationHeader(authorizationHeader) ?: throw Exception("Invalid token")
                return getRecommendedEventsForUser(user)
            } ?: return getRecommendedEventsGeneric()
        } catch (e: Exception) {
            if (e.message == "Invalid token") {
                throw ResponseStatusException(HttpStatus.UNAUTHORIZED, e.message)
            } else {
                throw ResponseStatusException(HttpStatus.BAD_REQUEST, e.message)
            }
        }
    }

    @GetMapping("artItem")
    fun getRecommendedArtItems(
        @RequestHeader(
            value = "Authorization",
            required = false
        ) authorizationHeader: String?
    ): List<ArtItemDTO> {
        try {
            authorizationHeader?.let {
                val user =
                    jwtService.getUserFromAuthorizationHeader(authorizationHeader) ?: throw Exception("Invalid token")
                return getRecommendedArtItemsForUser(user)
            } ?: return getRecommendedArtItemsGeneric()
        } catch (e: Exception) {
            if (e.message == "Invalid token") {
                throw ResponseStatusException(HttpStatus.UNAUTHORIZED, e.message)
            } else {
                throw ResponseStatusException(HttpStatus.BAD_REQUEST, e.message)
            }
        }
    }

    fun getRecommendedEventsGeneric(): List<EventDTO> {
        return (physicalExhibitionRepository.findAll().map { it.mapToDTO() } + onlineGalleryRepository.findAll().map { it.mapToDTO() }).sorted()
    }

    fun getRecommendedEventsForUser(user: RegisteredUser): List<EventDTO> {
        //        #TODO: implement this
        val list = physicalExhibitionRepository.findAll().map { it.mapToDTO() } + onlineGalleryRepository.findAll().map { it.mapToDTO() }

        return list.sorted()
    }

    fun getRecommendedArtItemsGeneric(): List<ArtItemDTO> {
        return (artItemRepository.findAll().stream().map(ArtItem::mapToDTO).collect(Collectors.toList())).sorted()
    }

    fun getRecommendedArtItemsForUser(user: RegisteredUser): List<ArtItemDTO> {
        //        #TODO: implement this
        val list = artItemRepository.findAll().stream().map(ArtItem::mapToDTO).collect(Collectors.toList())
        return list.sorted()
}

}