package com.group7.artshare.entity

import com.fasterxml.jackson.annotation.JsonIdentityInfo
import com.fasterxml.jackson.annotation.ObjectIdGenerators
import lombok.Data;
import javax.persistence.*;

import java.util.*;


@Data
@Entity
@PrimaryKeyJoinColumn(name = "id")
class PhysicalExhibition : Event(){

    @ManyToOne(fetch = FetchType.EAGER, cascade = [CascadeType.PERSIST])
    @JoinColumn(name = "location")
    @JsonIdentityInfo(generator = ObjectIdGenerators.PropertyGenerator::class, property = "id")
    var location: Location? = null

    @Column
    var rules: String? = null
}