package com.group7.artshare.entity

import lombok.Data;
import javax.persistence.*;

import java.util.*;


@Data
@Entity
@PrimaryKeyJoinColumn(name = "id")
class PhysicalExhibition : Event(){

    @ManyToOne(fetch = FetchType.EAGER, cascade = [CascadeType.PERSIST])
    @JoinColumn(name = "location")
    var location: Location? = null

    @Column
    var rules: String = ""

    @ManyToMany(cascade = [CascadeType.ALL])
    @JoinTable(
        name = "physical_exhibition_attendees",
        joinColumns = [JoinColumn(name = "attending_user_id")],
        inverseJoinColumns = [JoinColumn(name = "physical_exhibition_id")]
    )
    var attendees: Set<RegisteredUser> = HashSet()

    @ManyToMany(cascade = [CascadeType.ALL])
    @JoinTable(
        name = "physical_exhibition_bookmarked_by",
        joinColumns = [JoinColumn(name = "bookmarker_id")],
        inverseJoinColumns = [JoinColumn(name = "bookmarked_exhibition_id")]
    )
    var bookmarkedBy: Set<RegisteredUser> = HashSet()


}