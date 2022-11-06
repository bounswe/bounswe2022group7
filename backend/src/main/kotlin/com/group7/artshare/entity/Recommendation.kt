package com.group7.artshare.entity

import lombok.Data
import java.util.*
import javax.persistence.*
import kotlin.collections.ArrayList
import java.util.Calendar


@Data
@Entity
class Recommendation{
    @Id
    @GeneratedValue(strategy =  GenerationType.IDENTITY)
    val id: Long = 0L

    //TODO OneToOne Visitor

    @OneToMany(orphanRemoval = true, cascade = [CascadeType.ALL])
    var recommendedPhysicalExhibition: List<PhysicalExhibition> = ArrayList()

    @OneToMany(orphanRemoval = true, cascade = [CascadeType.ALL])
    var recommendedOnlineGallery: List<OnlineGallery> = ArrayList()

    @OneToMany(orphanRemoval = true, cascade = [CascadeType.ALL])
    var recommendedArts: List<ArtItem> = ArrayList()

    @OneToMany(orphanRemoval = true, cascade = [CascadeType.ALL])
    var recommendedArtists: List<Artist> = ArrayList()

}