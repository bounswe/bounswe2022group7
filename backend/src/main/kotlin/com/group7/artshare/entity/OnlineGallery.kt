package com.group7.artshare.entity

import com.fasterxml.jackson.annotation.JsonIdentityInfo
import com.fasterxml.jackson.annotation.ObjectIdGenerators
import com.group7.artshare.DTO.OnlineGalleryDTO
import lombok.Data
import java.util.ArrayList
import java.util.HashSet
import javax.persistence.*

@Data
@Entity
@PrimaryKeyJoinColumn(name = "id")
class OnlineGallery : Event(){
    @ManyToMany(cascade = [CascadeType.PERSIST, CascadeType.MERGE])
    @JoinTable(
        name = "galleries_art_items",
        joinColumns = [JoinColumn(name = "online_gallery_id", referencedColumnName = "id")],
        inverseJoinColumns = [JoinColumn(name = "art_item_id", referencedColumnName = "id")]
    )
    @JsonIdentityInfo(generator = ObjectIdGenerators.PropertyGenerator::class, property = "id")
    val artItems: MutableSet<ArtItem> = mutableSetOf()

    @Column
    val externalUrl: String? = null

    override fun mapToDTO(): OnlineGalleryDTO {
        val dto = OnlineGalleryDTO()
        dto.id = this.id
        dto.creatorId = this.creator?.id
        dto.creatorAccountInfo = this.creator?.accountInfo
        dto.creationDate = this.creationDate
        dto.commentList = this.commentList.map { it.mapToDTO() }.toMutableList()
        dto.eventInfo = this.eventInfo
        dto.participantUsernames = this.participants.map { it.accountInfo.username }.toMutableList()
        dto.artItemList = this.artItems.map { it.mapToDTO() }.toMutableList()
        dto.externalUrl = this.externalUrl
        return dto
    }
}