package com.group7.artshare.entity

import lombok.Data;
import javax.persistence.*;

import java.util.*;


@Data
@Entity
@PrimaryKeyJoinColumn(name = "id")
class PhysicalExhibition : Event(){

    @ManyToOne(fetch = FetchType.EAGER)
    @JoinColumn(name = "location")
    var location: Location? = null

    @Column
    var rules: String = ""

    //@ManyToMany(mappedBy = "allPhysicalExhibitions",cascade = [CascadeType.ALL])
    //var attendees: Set<RegisteredUser> = HashSet()

    //@ManyToMany(mappedBy = "bookmarkedPhysicalExhibitions",cascade = [CascadeType.ALL])
    //var bookmarkedBy: Set<RegisteredUser> = HashSet()


}