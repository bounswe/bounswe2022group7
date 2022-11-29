package com.group7.artshare.entity

import com.fasterxml.jackson.annotation.JsonIdentityInfo
import com.fasterxml.jackson.annotation.ObjectIdGenerators
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
    val platform: String = "ArtShare"

    @Column
    val externalUrl: String? = null
}