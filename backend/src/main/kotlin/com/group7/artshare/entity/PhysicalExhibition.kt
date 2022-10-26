package com.group7.artshare.entity

import lombok.Data;
import javax.persistence.*;

import java.util.*;


@Data
@Entity
@Table(name = "physical_exhibition")
class PhysicalExhibition{

    @Id
    @GeneratedValue
    var id: Long = 0L

    @ManyToOne(fetch = FetchType.EAGER)
    @JoinColumn(name = "location")
    var location: Location? = null;

    @Column
    var rules: String = ""
}