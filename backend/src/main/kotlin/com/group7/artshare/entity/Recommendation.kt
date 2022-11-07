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
    var recommendedPhysicalExhibition: MutableList<PhysicalExhibition> = mutableListOf()

    @OneToMany(orphanRemoval = true, cascade = [CascadeType.ALL])
    var recommendedOnlineGallery: MutableList<OnlineGallery> = mutableListOf()

    @OneToMany(orphanRemoval = true, cascade = [CascadeType.ALL])
    var recommendedArts: MutableList<ArtItem> = mutableListOf()

    @OneToMany(orphanRemoval = true, cascade = [CascadeType.ALL])
    var recommendedArtists: MutableList<Artist> = mutableListOf()

}