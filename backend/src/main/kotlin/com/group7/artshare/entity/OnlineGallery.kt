package com.group7.artshare.entity

import lombok.Data
import java.util.ArrayList
import java.util.HashSet
import javax.persistence.*

@Data
@Entity
@PrimaryKeyJoinColumn(name = "id")
class OnlineGallery : Event(){

    
    @OneToMany(orphanRemoval = true, fetch = FetchType.EAGER)
    val artItems: MutableList<ArtItem> = mutableListOf()

    @Column
    val platform: String = "ArtShare"

    @Column
    val externalUrl: String? = null

    //@ManyToMany(mappedBy = "allOnlineGalleries",cascade = [CascadeType.ALL])
    //var attendees: Set<RegisteredUser> = HashSet()

    //@ManyToMany(mappedBy = "bookmarkedOnlineGalleries",cascade = [CascadeType.ALL])
    //var bookmarkedBy: Set<RegisteredUser> = HashSet()



}