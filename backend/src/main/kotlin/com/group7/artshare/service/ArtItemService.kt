package com.group7.artshare.service

import com.group7.artshare.entity.*
import com.group7.artshare.repository.*
import com.group7.artshare.request.*
import org.springframework.http.HttpStatus
import org.springframework.stereotype.Service
import org.springframework.web.server.ResponseStatusException

@Service
class ArtItemService(
    private val artItemRepository: ArtItemRepository,
    private val artistRepository: ArtistRepository,
    private val imageRepository: ImageRepository
) {
    fun createArtItem(
        artItemRequest: ArtItemRequest,
        user: RegisteredUser
    ): ArtItem {
        val newArtItem = ArtItem()
        if(artItemRequest.artItemInfo?.imageId?.let { imageRepository.existsById(it) } == false)
            throw ResponseStatusException(HttpStatus.BAD_REQUEST, "There is no image in the database with this id")
        newArtItem.artItemInfo = artItemRequest.artItemInfo
        newArtItem.lastPrice = artItemRequest.lastPrice!!
        newArtItem.owner = user
        if (user is Artist){
            newArtItem.creator = user
            user.artItems.add(newArtItem)
        }
        else
            throw ResponseStatusException(HttpStatus.BAD_REQUEST, "Regular users cannot create physical exhibitions")
        artItemRepository.save(newArtItem)
        return newArtItem
    }

    fun deleteArtItem(
        id: Long,
        user: RegisteredUser
    ) {
        if(!artItemRepository.existsById(id)) throw ResponseStatusException(HttpStatus.BAD_REQUEST, "There is no art item in the database with corresponding id")
        if (user is Artist){
            var artItem: ArtItem = user.artItems.firstOrNull { it.id == id }
                ?: throw ResponseStatusException(HttpStatus.UNAUTHORIZED, "Art item does not belong to this user")
            user.artItems.remove(artItem)
            artItemRepository.delete(artItem)
        }
        else {
            throw ResponseStatusException(HttpStatus.UNAUTHORIZED, "Regular Users cannot delete art items")
        }
    }
}