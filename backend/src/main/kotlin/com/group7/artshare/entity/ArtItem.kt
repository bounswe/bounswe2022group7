package com.group7.artshare.entity

import com.fasterxml.jackson.annotation.JsonBackReference
import com.fasterxml.jackson.annotation.JsonManagedReference
import com.group7.artshare.DTO.ArtItemDTO
import lombok.Data;
import java.util.*
import javax.persistence.*;

@Data
@Entity
class ArtItem{

    @Id
    @GeneratedValue
    var id: Long = 0L

    @OneToOne(cascade = [CascadeType.ALL])
    @JoinColumn(name = "artItemInfo", referencedColumnName = "id")
    @JsonManagedReference
    var artItemInfo: ArtItemInfo? = null

    @ManyToOne(fetch = FetchType.EAGER)
    @JoinColumn(name = "creator")
    var creator: Artist? = null

    @Column
    @Temporal(TemporalType.TIMESTAMP)
    var creationDate: Date = Calendar.getInstance().time

    @ManyToOne(fetch = FetchType.EAGER)
    @JoinColumn(name = "owner")
    var owner: RegisteredUser? = null

    @Column
    var onAuction: Boolean = false

    @OneToOne(cascade = [CascadeType.ALL])
    @JoinColumn(name = "auction", referencedColumnName = "id")
    @JsonManagedReference
    var auction: Auction? = null

    @Column
    var lastPrice: Double = 0.0;

    @OneToMany(orphanRemoval = true, fetch = FetchType.EAGER, cascade = [CascadeType.ALL])
    var commentList: MutableList<Comment> = mutableListOf()

    @ManyToMany(mappedBy = "bookmarkedArtItems",cascade = [CascadeType.MERGE, CascadeType.PERSIST])
    @JsonBackReference
    var bookmarkedBy: MutableSet<RegisteredUser> = mutableSetOf()


    fun mapToDTO() : ArtItemDTO{
        var artItemDTO = ArtItemDTO()
        artItemDTO.name = this.artItemInfo?.name
        artItemDTO.description = this.artItemInfo?.description
        artItemDTO.category = this.artItemInfo?.category
        artItemDTO.imageUrl = this.artItemInfo?.imageUrl
        //labels = this.artItemInfo?.labels     TODO: gonna turn string into list
        artItemDTO.creatorAccountInfo = this.creator?.accountInfo
        artItemDTO.creatorId = this.creator?.id
        artItemDTO.creationDate = this.creationDate
        artItemDTO.ownerAccountInfo = this.owner?.accountInfo
        artItemDTO.ownerId = this.owner?.id
        artItemDTO.onAuction = this.onAuction
        artItemDTO.auction = this.auction
        artItemDTO.lastPrice = this.lastPrice
        for(comment in this.commentList){
            artItemDTO.commentList.add(comment.mapToDTO())
        }
        for(user in this.bookmarkedBy){
            artItemDTO.bookMarkedByIds.add(user.id)
        }

        return artItemDTO
    }

}