package com.group7.artshare.service

import com.group7.artshare.DTO.ArtItemDTO
import com.group7.artshare.DTO.EventDTO
import com.group7.artshare.entity.*
import com.group7.artshare.repository.*
import com.group7.artshare.request.*
import org.springframework.http.HttpStatus
import org.springframework.stereotype.Service
import org.springframework.web.server.ResponseStatusException
import java.util.stream.Collectors

@Service
class HomepageService(
    private val artItemRepository: ArtItemRepository,
    private val onlineGalleryRepository: OnlineGalleryRepository,
    private val physicalExhibitionRepository: PhysicalExhibitionRepository
) {

    fun getRecommendedEventsGeneric(): List<EventDTO> {
        return (physicalExhibitionRepository.findAll().map { it.mapToDTO() } + onlineGalleryRepository.findAll().map { it.mapToDTO() }).sorted()
    }

    fun getRecommendedEventsForUser(user: RegisteredUser): List<EventDTO> {
        val followingUserIds = user.following.map { it.id }
        val eventDTOs = physicalExhibitionRepository.findAll().map { it.mapToDTO() } + onlineGalleryRepository.findAll().map { it.mapToDTO() }
        val followingEventDTOs = eventDTOs.filter {followingUserIds.contains(it.creatorId)}
        val notFollowingEventDTOs = eventDTOs - followingEventDTOs.toSet()
        return followingEventDTOs.sorted() + notFollowingEventDTOs.sorted()
    }

    fun getRecommendedArtItemsGeneric(): List<ArtItemDTO> {
        return (artItemRepository.findAll().stream().map(ArtItem::mapToDTO).collect(Collectors.toList())).sorted()
    }

    fun getRecommendedArtItemsForUser(user: RegisteredUser): List<ArtItemDTO> {
        val followingUserIds = user.following.map { it.id }
        val artItemDTOs = artItemRepository.findAll().map { it.mapToDTO() }
        val followingArtItemDTOs = artItemDTOs.filter {followingUserIds.contains(it.creatorId)}
        val notFollowingArtItemDTOs = artItemDTOs - followingArtItemDTOs.toSet()
        return followingArtItemDTOs.sorted() + notFollowingArtItemDTOs.sorted()
    }
}