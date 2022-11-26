package com.group7.artshare.entity

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
    val artItems: MutableSet<ArtItem> = mutableSetOf()

    @Column
    val platform: String = "ArtShare"

    @Column
    val externalUrl: String? = null
}