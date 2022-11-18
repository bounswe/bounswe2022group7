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
class ArtItemService(
    private val artItemRepository: ArtItemRepository,
    private val artistRepository: ArtistRepository
) {
    fun createArtItem(
        artItemRequest: ArtItemRequest,
        user: RegisteredUser
    ): ArtItem {
        val newArtItem = ArtItem()
        if (user is Artist)
            newArtItem.creator = user
        else
            throw ResponseStatusException(HttpStatus.BAD_REQUEST, "Registered users cannot create physical exhibitions")
        newArtItem.artItemInfo = artItemRequest.artItemInfo
        newArtItem.lastPrice = artItemRequest.lastPrice!!
        val creator = artistRepository.findByIdOrNull(artItemRequest.creatorId) ?: throw Exception("Creator is not an artist user")
        newArtItem.creator = creator
        artItemRepository.save(newArtItem)
        return newArtItem
    }

}