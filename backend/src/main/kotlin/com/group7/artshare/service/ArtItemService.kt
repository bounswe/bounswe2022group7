package com.group7.artshare.service

import com.group7.artshare.entity.ArtItem
import com.group7.artshare.entity.Artist
import com.group7.artshare.entity.RegisteredUser
import com.group7.artshare.repository.ArtItemRepository
import com.group7.artshare.repository.ArtistRepository
import com.group7.artshare.repository.ImageRepository
import com.group7.artshare.request.ArtItemRequest
import org.springframework.data.repository.findByIdOrNull
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
        if (artItemRequest.artItemInfo?.imageId?.let { imageRepository.existsById(it) } == false)
            throw ResponseStatusException(HttpStatus.BAD_REQUEST, "There is no image in the database with this id")
        newArtItem.artItemInfo = artItemRequest.artItemInfo
        newArtItem.lastPrice = artItemRequest.lastPrice!!
        newArtItem.owner = user
        if (user is Artist) {
            newArtItem.creator = user
            user.artItems.add(newArtItem)
            user.level++
        } else
            throw ResponseStatusException(HttpStatus.BAD_REQUEST, "Regular users cannot create physical exhibitions")
        artItemRepository.save(newArtItem)
        return newArtItem
    }

    fun deleteArtItem(
        id: Long,
        user: RegisteredUser
    ) {
        if (!artItemRepository.existsById(id)) throw ResponseStatusException(
            HttpStatus.BAD_REQUEST,
            "There is no art item in the database with corresponding id"
        )
        if (user is Artist) {
            var artItem: ArtItem = user.artItems.firstOrNull { it.id == id }
                ?: throw ResponseStatusException(HttpStatus.UNAUTHORIZED, "Art item does not belong to this user")
            user.artItems.remove(artItem)
            artItemRepository.delete(artItem)
        } else {
            throw ResponseStatusException(HttpStatus.UNAUTHORIZED, "Regular Users cannot delete art items")
        }
    }

    fun bookmarkAnArtItem(
        id: Long,
        user: RegisteredUser
    ): ArtItem {
        val artItem: ArtItem = artItemRepository.findByIdOrNull(id) ?: throw ResponseStatusException(
            HttpStatus.BAD_REQUEST,
            "There is no art item in the database with corresponding id"
        )
        if(user.bookmarkedArtItems.contains(artItem)){
            user.bookmarkedArtItems.remove(artItem)
            artItem.bookmarkedBy.remove(user)
        }else {
            user.bookmarkedArtItems.add(artItem)
            artItem.bookmarkedBy.add(user)
        }
        artItemRepository.flush()
        return artItem
    }

    fun likeAnArtItem(
        id: Long,
        user: RegisteredUser
    ): ArtItem {
        val artItem: ArtItem = artItemRepository.findByIdOrNull(id) ?: throw ResponseStatusException(
            HttpStatus.BAD_REQUEST,
            "There is no art item in the database with corresponding id"
        )
        if(user.likedArtItems.contains(artItem)){
            user.likedArtItems.remove(artItem)
            artItem.likedBy.remove(user)
        }else {
            user.likedArtItems.add(artItem)
            artItem.likedBy.add(user)
        }
        artItemRepository.flush()
        return artItem
    }

    fun auctionAnArtItem(
        id: Long,
        user: RegisteredUser
    ): ArtItem {
        val artItem: ArtItem = artItemRepository.findByIdOrNull(id) ?: throw ResponseStatusException(
            HttpStatus.BAD_REQUEST,
            "There is no art item in the database with corresponding id"
        )
        if(user is Artist) {
            if(user.artItems.contains(artItem)){
                artItem.onAuction = !artItem.onAuction
            }
            else
                throw ResponseStatusException(
                HttpStatus.UNAUTHORIZED,
                "Art item does not belong to this user"
            )
        }
        else
            throw ResponseStatusException(
                HttpStatus.BAD_REQUEST,
                "Regular Users cannot put art items on auction"
            )
        artItemRepository.flush()
        return artItem
    }

    fun bidAnArtItem(
        id: Long,
        user: RegisteredUser
    ): ArtItem {
        val artItem: ArtItem = artItemRepository.findByIdOrNull(id) ?: throw ResponseStatusException(
            HttpStatus.BAD_REQUEST,
            "There is no art item in the database with corresponding id"
        )

        artItemRepository.flush()
        return artItem
    }
}