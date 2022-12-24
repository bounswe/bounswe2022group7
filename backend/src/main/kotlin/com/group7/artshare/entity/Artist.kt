package com.group7.artshare.entity

import com.fasterxml.jackson.annotation.*
import com.group7.artshare.DTO.ArtistDTO
import com.group7.artshare.DTO.RegisteredUserDTO
import java.util.ArrayList
import javax.persistence.*

@Entity(name="Artist")
class Artist(accountInfo: AccountInfo, authorities: Set<Authority>) : RegisteredUser(accountInfo, authorities) {

    @ManyToMany(cascade = [CascadeType.PERSIST, CascadeType.MERGE])
    @JoinTable(
        name = "artist_hosted_events",
        joinColumns = [JoinColumn(name = "artist_id", referencedColumnName = "id")],
        inverseJoinColumns = [JoinColumn(name = "event_id", referencedColumnName = "id")]
    )
    @JsonIdentityInfo(generator = ObjectIdGenerators.PropertyGenerator::class, property = "id")
    var hostedEvents: MutableSet<Event> = mutableSetOf()

    @OneToMany(orphanRemoval = true, fetch = FetchType.EAGER, cascade = [CascadeType.ALL])
    @JsonIdentityInfo(generator = ObjectIdGenerators.PropertyGenerator::class, property = "id")
    var artItems: MutableSet<ArtItem> = mutableSetOf()

    @Column
    var totalSales: Int = 0

    override fun mapToDTO(): ArtistDTO {
        val artistDTO = ArtistDTO()
        artistDTO.id = id
        artistDTO.accountInfo = accountInfo
        artistDTO.isVerified = isVerified
        artistDTO.level = level
        artistDTO.xp = xp
        artistDTO.isBanned = isBanned
        artistDTO.followingUsernames = following.map { it.accountInfo.username }.toMutableSet()
        artistDTO.followedByUsernames = followedBy.map { it.accountInfo.username }.toMutableSet()
        artistDTO.likedArtItemIds = likedArtItems.map { it.id }.toMutableList()
        artistDTO.bookmarkedArtItemIds = bookmarkedArtItems.map { it.id }.toMutableList()
        artistDTO.bookmarkedEventIds = bookmarkedEvents.map { it.id }.toMutableList()
        artistDTO.participatedEventIds = allEvents.map { it.id }.toMutableList()
        artistDTO.discussionPostIds = writtenDiscussionPosts.map { it.id }.toMutableList()
        artistDTO.commentIds = commentList.map { it.id }.toMutableList()
        artistDTO.hostedEventIds = hostedEvents.map { it.id }.toMutableList()
        artistDTO.artItems = artItems.map { it.mapToDTO() }.toMutableList()
        artistDTO.totalSales = totalSales
        return artistDTO
    }
}